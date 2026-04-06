const { getRedisClient } = require('../../config/redis');
const embeddingService = require('./embedding.service');
const logger = require('../../utils/logger');

const INDEX_NAME = 'posts:index';

/**
 * Indexa un post en Redis para búsqueda vectorial.
 * @param {Object} post - Objeto Post (debe tener id, content, authorId)
 */
async function indexPost(post) {
    try {
        const client = await getRedisClient();
        const embedding = await embeddingService.generateEmbedding(post.content);

        if (!embedding) {
            logger.warn(`[SearchService] Skipping indexing for post ${post.id}: No embedding generated`);
            return;
        }

        const key = `post:${post.id}`;
        const data = {
            content: post.content,
            authorId: post.userId || post.authorId, // Asegurar compatibilidad
            embedding: embedding
        };

        // Usamos JSON.SET para guardar el documento
        await client.json.set(key, '$', data);
        logger.info(`[SearchService] Indexed post ${post.id}`);
    } catch (error) {
        logger.error(`[SearchService] Error indexing post ${post.id}: ${error.message}`);
        // No lanzamos error para no afectar el flujo principal
    }
}

/**
 * Busca posts semánticamente similares.
 * @param {string} query - Texto de búsqueda
 * @param {number} limit - Cantidad de resultados
 * @returns {Promise<string[]>} Lista de IDs de posts
 */
async function search(query, limit = 10) {
    try {
        const client = await getRedisClient();
        const embedding = await embeddingService.generateEmbedding(query);

        if (!embedding) return [];

        // Construir consulta vectorial (KNN)
        // Sintaxis: "*=>[KNN <k> @embedding $BLOB AS score]"
        // Ordenar por score (distancia coseno, menor es mejor/más similar)
        const vectorQuery = `*=>[KNN ${limit} @embedding $blob AS score]`;

        // Convertir embedding a Buffer de Float32 (Little Endian)
        const float32Array = new Float32Array(embedding);
        const blob = Buffer.from(float32Array.buffer);

        const results = await client.ft.search(
            INDEX_NAME,
            vectorQuery,
            {
                PARAMS: {
                    blob: blob
                },
                SORTBY: 'score',
                DIALECT: 2, // Necesario para sintaxis vectorial moderna
                RETURN: ['score'] // Solo necesitamos el ID (que viene en la key) y el score
            }
        );

        // results.documents contiene { id: 'post:uuid', value: { score: ... } }
        // Extraemos solo el UUID
        return results.documents.map(doc => doc.id.replace('post:', ''));
    } catch (error) {
        logger.error(`[SearchService] Error searching: ${error.message}`);
        return [];
    }
}

/**
 * Busca posts semánticamente similares filtrados por autor.
 * @param {string} query - Texto de búsqueda
 * @param {string} userId - UUID del autor
 * @param {number} limit - Cantidad de resultados
 * @returns {Promise<string[]>} Lista de IDs de posts
 */
async function searchByUser(query, userId, limit = 10) {
    try {
        const client = await getRedisClient();
        const embedding = await embeddingService.generateEmbedding(query);

        if (!embedding) return [];

        // Construir consulta vectorial con filtro (KNN)
        // Escapar guiones en UUID para RediSearch si es necesario
        const escapedUserId = userId.replace(/-/g, '\\-');
        const vectorQuery = `(@authorId:{${escapedUserId}})=>[KNN ${limit} @embedding $blob AS score]`;

        const float32Array = new Float32Array(embedding);
        const blob = Buffer.from(float32Array.buffer);

        const results = await client.ft.search(
            INDEX_NAME,
            vectorQuery,
            {
                PARAMS: {
                    blob: blob
                },
                SORTBY: 'score',
                DIALECT: 2,
                RETURN: ['score']
            }
        );

        return results.documents.map(doc => doc.id.replace('post:', ''));
    } catch (error) {
        logger.error(`[SearchService] Error searching by user: ${error.message}`);
        return [];
    }
}

module.exports = {
    indexPost,
    search,
    searchByUser
};

