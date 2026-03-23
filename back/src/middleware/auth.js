const jwt = require('jsonwebtoken');
const logger = require('../utils/logger');
const { config } = require('../config');

/**
 * Middleware de autenticación JWT.
 * Verifica el token en el header Authorization.
 * Si es válido, adjunta el payload a req.user.
 */
const authenticate = (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;

        logger.debug(`[AuthMiddleware] Authorization Header: ${authHeader ? 'Present' : 'Missing'}`);

        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            logger.warn('[AuthMiddleware] ❌ No valid auth header');
            return res.status(401).json({ error: 'Unauthorized: No token provided' });
        }

        const token = authHeader.split(' ')[1];
        logger.debug(`[AuthMiddleware] Extracted Token: ${token.substring(0, 20)}...`);

        // Use the same secret from centralized config
        const decoded = jwt.verify(token, config.jwt.secret);
        logger.info(`[AuthMiddleware] ✅ Token decoded successfully for user: ${decoded.id}`);

        req.user = {
            id: decoded.id,
            role: decoded.role
        };

        next();
    } catch (error) {
        if (error.name === 'TokenExpiredError') {
            logger.error('[AuthMiddleware] ❌ Token has expired');
            return res.status(401).json({ error: 'Unauthorized: Token expired' });
        }
        logger.error(`[AuthMiddleware] ❌ Token verification failed: ${error.message}`);
        return res.status(401).json({ error: 'Unauthorized: Invalid token' });
    }
};

module.exports = { authenticate };

