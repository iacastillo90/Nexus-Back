const redis = require('redis');
const logger = require('../utils/logger');

let client = null;

/**
 * Obtiene el cliente de Redis (Singleton).
 * Implementa reconnection strategy y error handling.
 * 
 * @returns {Promise<import('redis').RedisClientType>} Cliente conectado
 * @throws {Error} Si falla la conexión después de reintentos
 */
async function getRedisClient() {
  if (!client) {
    client = redis.createClient({
      url: process.env.REDIS_URL || 'redis://localhost:6379',
      socket: {
        reconnectStrategy: (retries) => {
          if (retries > 10) {
            logger.error('[Redis] Max reconnection attempts reached');
            return new Error('Redis connection failed');
          }
          return Math.min(retries * 100, 3000); // Backoff con cap
        }
      }
    });

    client.on('error', (err) => logger.error('[Redis] Error:', err));
    client.on('connect', () => logger.info('[Redis] Connected successfully'));

    await client.connect();
  }
  return client;
}

/**
 * Inicializa el índice vectorial en Redis si no existe.
 */
async function initVectorIndex() {
  const client = await getRedisClient();
  const indexName = 'posts:index';

  try {
    await client.ft.info(indexName);
    logger.info('[Redis] Vector index already exists');
  } catch (error) {
    if (error.message === 'Unknown Index name') {
      logger.info('[Redis] Creating vector index...');
      try {
        await client.ft.create(
          indexName,
          {
            '$.embedding': {
              type: 'VECTOR',
              ALGORITHM: 'HNSW', // Hierarchical Navigable Small World
              TYPE: 'FLOAT32',
              DIM: 1536, // OpenAI text-embedding-3-small dimension
              DISTANCE_METRIC: 'COSINE',
              AS: 'embedding'
            },
            '$.content': {
              type: 'TEXT',
              AS: 'content'
            },
            '$.authorId': {
              type: 'TAG',
              AS: 'authorId'
            }
          },
          {
            ON: 'JSON',
            PREFIX: 'post:'
          }
        );
        logger.info('[Redis] Vector index created successfully');
      } catch (createError) {
        logger.error(`[Redis] Error creating index: ${createError.message}`);
      }
    } else {
      logger.error(`[Redis] Error checking index: ${error.message}`);
    }
  }
}

module.exports = { getRedisClient, initVectorIndex };

