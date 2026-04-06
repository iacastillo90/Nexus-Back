const searchService = require('./search.service');
const postRepository = require('../repositories/post.repository');
const logger = require('../../utils/logger');

/**
 * Busca posts semánticamente.
 */
async function searchPosts(req, res, next) {
    try {
        const { q, limit } = req.query;

        if (!q) {
            return res.status(400).json({ error: 'Query parameter "q" is required' });
        }

        const maxLimit = parseInt(limit) || 10;

        // 1. Obtener IDs de Redis (búsqueda vectorial)
        const postIds = await searchService.search(q, maxLimit);

        if (postIds.length === 0) {
            return res.status(200).json({ data: [] });
        }

        // 2. Hidratar posts desde MySQL
        // Nota: Esto no garantiza el orden por relevancia. 
        // Si queremos mantener el orden, tendríamos que reordenar en memoria.
        // Para MVP, devolvemos los posts encontrados.

        const posts = await postRepository.findAllByIds(postIds);

        // Filtrar nulos (si algún post se borró de DB pero quedó en Redis)
        const validPosts = posts.filter(p => p !== null);

        res.status(200).json({
            data: validPosts,
            meta: {
                total: validPosts.length,
                query: q
            }
        });
    } catch (error) {
        next(error);
    }
}

module.exports = {
    searchPosts
};

