const AIFactory = require('./ai/ai.factory');
const logger = require('../utils/logger');
const { ExternalAPIError } = require('../utils/errors');

/**
 * Genera un embedding vectorial para un texto dado.
 * @param {string} text - Texto a procesar
 * @returns {Promise<number[]>} Vector de embedding (1536 dimensiones)
 */
async function generateEmbedding(text) {
    try {
        if (!text) return null;

        const provider = AIFactory.getProvider();
        const vector = await provider.generateEmbedding(text);

        return vector;
    } catch (error) {
        logger.error(`[EmbeddingService] Error generating embedding: ${error.message}`);
        // No lanzamos error para no romper el flujo principal (crear post), 
        // pero loggeamos. Podríamos reintentar o usar una cola.
        // Para "God-Level", deberíamos manejar esto robustamente, pero por ahora loggeamos.
        throw new ExternalAPIError('Failed to generate embedding');
    }
}

module.exports = {
    generateEmbedding
};

