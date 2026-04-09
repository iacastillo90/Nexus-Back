const jwt = require('jsonwebtoken');
const logger = require('../utils/logger');

/**
 * Middleware de autenticación para Socket.IO.
 * Verifica el token JWT en el handshake.
 */
function authenticateSocket(socket, next) {
    try {
        const token = socket.handshake.auth.token || socket.handshake.headers.authorization?.split(' ')[1];

        if (!token) {
            return next(new Error('Authentication error: No token provided'));
        }

        const { config } = require('../config');
        const secret = config.jwt.secret;
        const decoded = jwt.verify(token, secret);

        // Adjuntar datos del usuario al socket
        socket.userId = decoded.id;
        socket.username = decoded.username;

        logger.debug(`[Socket.IO] User ${decoded.username} authenticated`);
        next();
    } catch (error) {
        logger.error(`[Socket.IO] Authentication failed: ${error.message}`);
        next(new Error('Authentication error: Invalid token'));
    }
}

module.exports = authenticateSocket;

