const { Pinecone } = require('@pinecone-database/pinecone');
const { env } = require('../../config/env.config');
const logger = require('../../utils/logger');

class VectorService {
    constructor() {
        if (!env.PINECONE_API_KEY) {
            logger.warn('[VectorService] PINECONE_API_KEY is not set. Vector search will be mocked.');
            this.client = null;
        } else {
            this.client = new Pinecone({
                apiKey: env.PINECONE_API_KEY,
            });
            this.index = this.client.index(env.PINECONE_INDEX || 'nexus-ai-memory');
        }
    }

    /**
     * Upsert a vector embedding to Pinecone
     */
    async upsertVector(id, vector, metadata = {}) {
        if (!this.client) {
            logger.debug(`[VectorService] Mock Upsert vector ${id}`);
            return true;
        }

        try {
            await this.index.upsert([{
                id,
                values: vector,
                metadata
            }]);
            return true;
        } catch (error) {
            logger.error(`[VectorService] Error upserting vector: ${error.message}`);
            return false;
        }
    }

    /**
     * Search similar vectors by userId
     */
    async searchByUser(vector, userId, topK = 5) {
        if (!this.client) {
            logger.debug(`[VectorService] Mock Search for user ${userId}`);
            return []; // Mock empty response
        }

        try {
            const results = await this.index.query({
                vector,
                topK,
                filter: { userId: { $eq: userId } },
                includeMetadata: true
            });
            return results.matches || [];
        } catch (error) {
            logger.error(`[VectorService] Error searching vectors: ${error.message}`);
            return [];
        }
    }
}

module.exports = new VectorService();
