const cacheService = require('../services/cache.service');
const logger = require('../utils/logger');

/**
 * Middleware de caché para endpoints GET.
 * Si existe valor en caché, responde inmediatamente.
 * Si no existe, permite que el handler procese y luego cachea el resultado.
 * 
 * @param {Function} keyGenerator - Función que genera la clave de caché desde req
 * @param {number} ttl - Tiempo de vida del caché en segundos
 * 
 * @example
 * router.get('/feed', 
 *   cacheMiddleware((req) => `feed:${req.user.id}:page:${req.query.page}`, 60),
 *   feedController.getFeed
 * );
 */
function cacheMiddleware(keyGenerator, ttl = 60) {
    return async (req, res, next) => {
        // Solo cachear GET requests
        if (req.method !== 'GET') {
            return next();
        }

        try {
            const cacheKey = keyGenerator(req);
            const cachedData = await cacheService.get(cacheKey);

            if (cachedData) {
                logger.info(`[CacheMiddleware] Serving from cache: ${cacheKey}`);
                return res.json(cachedData);
            }

            // Si no hay caché, interceptamos res.json para guardar la respuesta
            const originalJson = res.json.bind(res);

            res.json = function (data) {
                // Guardar en caché solo respuestas exitosas (2xx)
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    cacheService.set(cacheKey, data, ttl).catch(err =>
                        logger.error(`[CacheMiddleware] Failed to cache: ${err.message}`)
                    );
                }
                return originalJson(data);
            };

            next();
        } catch (error) {
            logger.error(`[CacheMiddleware] Error: ${error.message}`);
            next(); // Continuar sin caché si hay error
        }
    };
}

module.exports = { cacheMiddleware };

