const authenticateSocket = require('./auth.middleware');
const logger = require('../utils/logger');
const presenceService = require('../services/presence.service');

/**
 * Configura los event handlers de Socket.IO.
 * @param {import('socket.io').Server} io - Instancia de Socket.IO
 */
function setupSocketHandlers(io) {
    // Middleware de autenticación
    io.use(authenticateSocket);

    io.on('connection', async (socket) => {
        logger.info(`[Socket.IO] User ${socket.username} connected (${socket.id})`);

        // Marcar usuario como online
        await presenceService.setUserOnline(socket.userId, socket.id);

        // Unir al usuario a su sala personal (para notificaciones)
        socket.join(`user:${socket.userId}`);

        // --- Event Handlers ---

        // Suscribirse al feed
        socket.on('join:feed', () => {
            socket.join('feed');
            logger.debug(`[Socket.IO] User ${socket.username} joined feed`);
        });

        // Desuscribirse del feed
        socket.on('leave:feed', () => {
            socket.leave('feed');
            logger.debug(`[Socket.IO] User ${socket.username} left feed`);
        });

        // Marcar notificación como leída
        socket.on('mark:notification:read', async (notificationId) => {
            try {
                const notificationService = require('../services/notification.service');
                await notificationService.markAsRead(notificationId, socket.userId);
                socket.emit('notification:marked', { notificationId });
            } catch (error) {
                logger.error(`[Socket.IO] Error marking notification: ${error.message}`);
                socket.emit('error', { message: 'Failed to mark notification' });
            }
        });

        // Desconexión
        socket.on('disconnect', async () => {
            logger.info(`[Socket.IO] User ${socket.username} disconnected (${socket.id})`);
            await presenceService.setUserOffline(socket.userId, socket.id);
        });
    });

    logger.info('[Socket.IO] Event handlers configured');
}

module.exports = setupSocketHandlers;

