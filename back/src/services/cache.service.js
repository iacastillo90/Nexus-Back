const { getRedisClient } = require('../config/redis');
const logger = require('../utils/logger');

/**
 * Obtiene un valor del caché.
 * 
 * @param {string} key - Clave de caché
 * @returns {Promise<any|null>} Valor parseado o null si no existe
 */
async function get(key) {
    try {
        const redis = await getRedisClient();
        const value = await redis.get(key);

        if (!value) {
            logger.debug(`[Cache] MISS: ${key}`);
            return null;
        }

        logger.debug(`[Cache] HIT: ${key}`);
        return JSON.parse(value);
    } catch (error) {
        logger.error(`[Cache] Error getting key ${key}:`, error);
        return null; // Fail gracefully
    }
}

/**
 * Guarda un valor en caché con TTL.
 * 
 * @param {string} key - Clave de caché
 * @param {any} value - Valor a guardar (será serializado)
 * @param {number} ttl - Tiempo de vida en segundos
 * @returns {Promise<boolean>} True si se guardó exitosamente
 */
async function set(key, value, ttl = 3600) {
    try {
        const redis = await getRedisClient();
        await redis.setEx(key, ttl, JSON.stringify(value));
        logger.debug(`[Cache] SET: ${key} (TTL: ${ttl}s)`);
        return true;
    } catch (error) {
        logger.error(`[Cache] Error setting key ${key}:`, error);
        return false;
    }
}

/**
 * Invalida una clave específica.
 * 
 * @param {string} key - Clave a invalidar
 */
async function invalidate(key) {
    try {
        const redis = await getRedisClient();
        await redis.del(key);
        logger.debug(`[Cache] INVALIDATE: ${key}`);
    } catch (error) {
        logger.error(`[Cache] Error invalidating key ${key}:`, error);
    }
}

/**
 * Invalida todas las claves que coincidan con un patrón.
 * Útil para invalidar feeds de múltiples usuarios.
 * 
 * @param {string} pattern - Patrón de búsqueda (ej: "feed:*")
 */
async function invalidatePattern(pattern) {
    try {
        const redis = await getRedisClient();
        const keys = await redis.keys(pattern);

        if (keys.length > 0) {
            await redis.del(keys);
            logger.debug(`[Cache] INVALIDATE PATTERN: ${pattern} (${keys.length} keys)`);
        }
    } catch (error) {
        logger.error(`[Cache] Error invalidating pattern ${pattern}:`, error);
    }
}

module.exports = { get, set, invalidate, invalidatePattern };

