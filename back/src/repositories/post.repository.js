const { Post, User } = require('../models');
const logger = require('../utils/logger');

/**
 * @fileoverview Repositorio para la entidad Post.
 * @module repositories/postRepository
 */

/**
 * Crea un nuevo post.
 * @param {Object} postData - Datos del post
 * @returns {Promise<Post>} Post creado
 */
async function create(postData) {
    try {
        const post = await Post.create(postData);
        logger.debug(`[PostRepository] Post created: ${post.id}`);
        return post;
    } catch (error) {
        logger.error(`[PostRepository] Error creating post: ${error.message}`);
        throw error;
    }
}

/**
 * Encuentra posts paginados para el feed.
 * @param {number} limit - Límite de posts
 * @param {number} offset - Offset para paginación
 * @returns {Promise<Post[]>} Lista de posts con autor
 */
async function findAllPaginated(limit = 20, offset = 0) {
    try {
        return await Post.findAll({
            limit,
            offset,
            order: [['createdAt', 'DESC']],
            include: [{
                model: User,
                as: 'author',
                attributes: ['id', 'username', 'avatarUrl']
            }]
        });
    } catch (error) {
        logger.error(`[PostRepository] Error finding posts: ${error.message}`);
        throw error;
    }
}

/**
 * Encuentra un post por ID.
 * @param {string} id - ID del post
 * @returns {Promise<Post>} Post encontrado
 */
async function findById(id) {
    try {
        return await Post.findByPk(id, {
            include: [{
                model: User,
                as: 'author',
                attributes: ['id', 'username', 'avatarUrl']
            }]
        });
    } catch (error) {
        logger.error(`[PostRepository] Error finding post ${id}: ${error.message}`);
        throw error;
    }
}

/**
 * Encuentra múltiples posts por sus IDs.
 * @param {string[]} ids - Array de IDs de posts
 * @returns {Promise<Post[]>} Lista de posts encontrados
 */
async function findAllByIds(ids) {
    try {
        return await Post.findAll({
            where: {
                id: ids
            },
            include: [{
                model: User,
                as: 'author',
                attributes: ['id', 'username', 'avatarUrl']
            }]
        });
    } catch (error) {
        logger.error(`[PostRepository] Error finding posts by IDs: ${error.message}`);
        throw error;
    }
}

module.exports = {
    create,
    findAllPaginated,
    findById,
    findAllByIds
};

