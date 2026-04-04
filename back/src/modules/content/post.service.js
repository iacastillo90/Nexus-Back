const postRepository = require('../repositories/post.repository');
const cacheService = require('./cache.service');
const searchService = require('./search.service');
const contentDNAService = require('./contentDNA.service');
const logger = require('../../utils/logger');
const { ValidationError } = require('../../utils/errors');

/**
 * Crea un nuevo post e invalida cachés.
 * @param {string} authorId - ID del autor
 * @param {string} content - Contenido del post
 * @param {string} mediaUrl - URL multimedia opcional
 * @param {Object} location - { lat, lng } opcional
 * @param {Object} arMetadata - Metadata AR opcional
 * @param {string} [mediaPath] - Ruta local del archivo (para generar hash)
 * @param {Object} [options] - Opciones adicionales
 * @param {boolean} [options.checkDuplicate=true] - Verificar si media es duplicado
 * @returns {Promise<Object>} Post creado
 */
async function createPost(authorId, content, mediaUrl = null, location = null, arMetadata = null, mediaPath = null, options = {}) {
    const { checkDuplicate = true } = options;
    try {
        if (!content) {
            throw new ValidationError('Content is required');
        }

        logger.info(`[PostService] Creating post for user ${authorId}`);

        // 1. Verificar si media es duplicado (si se solicitó)
        let duplicateInfo = null;
        if (mediaPath && checkDuplicate) {
            duplicateInfo = await contentDNAService.detectDuplicateMedia(mediaPath);

            if (duplicateInfo.isDuplicate) {
                logger.warn('[PostService] Duplicate media detected', {
                    authorId,
                    originalAuthor: duplicateInfo.matches[0].authorId
                });
            }
        }

        // 2. Generar Content DNA ANTES de guardar en DB
        const contentDNA = await contentDNAService.generateContentDNA({
            authorId,
            contentText: content,
            mediaPath,
            contentType: 'post'
        });

        let geolocation = null;
        if (location && location.lat && location.lng) {
            geolocation = { type: 'Point', coordinates: [location.lng, location.lat] }; // GeoJSON format: [lng, lat]
        }

        const post = await postRepository.create({
            userId: authorId,
            content,
            mediaUrl,
            isPrivate: false, // Default public for now
            geolocation,
            arMetadata,
            contentDna: contentDNA.dnaHash // Agregar DNA al post
        });

        // --- Cache Invalidation Strategy ---

        // 1. Invalidar feed del autor (si ve su propio perfil/feed)
        await cacheService.invalidate(`feed:${authorId}:page:1`);

        // 2. Invalidar feeds de seguidores
        // Obtenemos los seguidores para invalidar sus feeds
        const { Follow } = require('../../models');
        const followers = await Follow.findAll({
            where: { followingId: authorId },
            attributes: ['followerId']
        });

        // Invalidamos el feed de cada seguidor (página 1)
        // Nota: Para muchos seguidores, esto debería ir a una cola de tareas (Worker)
        const invalidationPromises = followers.map(f =>
            cacheService.invalidate(`feed:${f.followerId}:page:1`)
        );

        await Promise.all(invalidationPromises);

        // 3. Invalidar trending/global si aplica
        await cacheService.invalidate('posts:trending');

        // 4. Indexar en Redis para búsqueda semántica (Fire & Forget)
        // No esperamos a que termine para responder rápido al usuario
        searchService.indexPost(post).catch(err =>
            logger.error(`[PostService] Error indexing post ${post.id}: ${err.message}`)
        );

        // 5. Emitir evento en tiempo real para feed live
        try {
            const { getIO } = require('../../config/socket');
            const io = getIO();
            io.to('feed').emit('feed:new_post', {
                id: post.id,
                content: post.content,
                authorId: authorId,
                createdAt: post.createdAt,
                contentDna: contentDNA.dnaHash
            });
            logger.debug(`[PostService] Emitted feed:new_post for post ${post.id}`);
        } catch (socketError) {
            // Socket.IO no inicializado - no es crítico
            logger.debug(`[PostService] Could not emit feed event: ${socketError.message}`);
        }

        // 6. Trigger Sentiment Analysis (Fire & Forget)
        const vibesService = require('./vibes.service');
        vibesService.analyzePostSentiment(post.id).catch(err =>
            logger.error(`[PostService] Error triggering sentiment analysis: ${err.message}`)
        );

        // 7. Fetch the created post with user info for response
        const { Post, User } = require('../../models');
        const postWithUser = await Post.findByPk(post.id, {
            include: [{
                model: User,
                as: 'author',
                attributes: ['id', 'username', 'firstName', 'lastName', 'avatarUrl']
            }]
        });

        // 8. Format response with user info and engagement counters
        return {
            id: postWithUser.id,
            userId: postWithUser.userId,
            username: postWithUser.author.username,
            userAvatar: postWithUser.author.avatarUrl,
            firstName: postWithUser.author.firstName,
            lastName: postWithUser.author.lastName,
            content: postWithUser.content,
            mediaUrl: postWithUser.mediaUrl,
            visibility: postWithUser.visibility || 'PUBLIC',
            geolocation: postWithUser.geolocation,
            arMetadata: postWithUser.arMetadata,
            contentDna: contentDNA.dnaHash,
            verificationUrl: contentDNA.verificationUrl,
            isOriginal: !duplicateInfo?.isDuplicate,
            // Engagement counters (initially 0 for new posts)
            likesCount: 0,
            commentsCount: 0,
            sharesCount: 0,
            viewsCount: 0,
            // User interaction flags (false for author's own post)
            isLiked: false,
            isBookmarked: false,
            createdAt: postWithUser.createdAt,
            updatedAt: postWithUser.updatedAt,
            ...(duplicateInfo?.isDuplicate && {
                duplicateWarning: true,
                originalContent: duplicateInfo.matches[0]
            })
        };
    } catch (error) {
        logger.error(`[PostService] Error creating post: ${error.message}`);
        throw error;
    }
}

/**
 * Obtiene el feed de posts.
 * @param {number} page - Número de página
 * @param {number} limit - Posts por página
 * @returns {Promise<Object[]>} Lista de posts
 */
async function getFeed(page = 1, limit = 20) {
    try {
        const offset = (page - 1) * limit;
        return await postRepository.findAllPaginated(limit, offset);
    } catch (error) {
        logger.error(`[PostService] Error fetching feed: ${error.message}`);
        throw error;
    }
}

/**
 * Busca posts cercanos a una ubicación.
 * @param {number} lat - Latitud
 * @param {number} lng - Longitud
 * @param {number} radiusInMeters - Radio en metros
 * @returns {Promise<Object[]>} Posts cercanos
 */
async function getPostsByLocation(lat, lng, radiusInMeters = 1000) {
    const { Post, User, sequelize } = require('../../models');

    // Fallback to ST_Distance (degrees) if ST_Distance_Sphere is not available
    // 1 degree approx 111320 meters
    const radiusInDegrees = radiusInMeters / 111320;

    const posts = await Post.findAll({
        where: sequelize.where(
            sequelize.fn(
                'ST_Distance',
                sequelize.col('geolocation'),
                sequelize.fn('POINT', lng, lat) // Longitude first for POINT
            ),
            {
                [require('sequelize').Op.lte]: radiusInDegrees
            }
        ),
        include: [
            { model: User, as: 'author', attributes: ['id', 'username'] }
        ],
        order: [
            [sequelize.fn('ST_Distance', sequelize.col('geolocation'), sequelize.fn('POINT', lng, lat)), 'ASC']
        ]
    }).catch(err => {
        require('../../utils/logger').error(`[PostService] Spatial query error: ${err.message}`);
        throw err;
    });

    return posts;
}

module.exports = {
    createPost,
    getFeed,
    getPostsByLocation
};

