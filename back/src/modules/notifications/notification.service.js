const { Notification } = require('../../models');
const logger = require('../../utils/logger');

/**
 * Crea una notificación y la emite en tiempo real.
 * @param {string} userId - ID del usuario receptor
 * @param {string} type - Tipo de notificación (like, comment, follow, etc.)
 * @param {Object} data - Datos adicionales
 * @returns {Promise<Object>} Notificación creada
 */
async function createNotification(userId, type, data) {
    try {
        const notification = await Notification.create({
            userId,
            type,
            content: data.content || '',
            relatedId: data.relatedId || null,
            relatedType: data.relatedType || null,
            isRead: false
        });

        // Emitir en tiempo real
        const { getIO } = require('../../config/socket');
        try {
            const io = getIO();
            io.to(`user:${userId}`).emit('notification:new', {
                id: notification.id,
                type: notification.type,
                content: notification.content,
                createdAt: notification.createdAt
            });
            logger.debug(`[NotificationService] Emitted notification to user ${userId}`);
        } catch (socketError) {
            // Socket.IO no inicializado o usuario no conectado - no es crítico
            logger.debug(`[NotificationService] Could not emit notification: ${socketError.message}`);
        }

        return notification;
    } catch (error) {
        logger.error(`[NotificationService] Error creating notification: ${error.message}`);
        throw error;
    }
}

/**
 * Obtiene las notificaciones de un usuario.
 * @param {string} userId - ID del usuario
 * @param {number} limit - Cantidad de notificaciones
 * @returns {Promise<Object[]>} Lista de notificaciones
 */
async function getNotifications(userId, limit = 20) {
    try {
        return await Notification.findAll({
            where: { userId },
            order: [['createdAt', 'DESC']],
            limit
        });
    } catch (error) {
        logger.error(`[NotificationService] Error fetching notifications: ${error.message}`);
        throw error;
    }
}

/**
 * Marca una notificación como leída.
 * @param {string} notificationId - ID de la notificación
 * @param {string} userId - ID del usuario (para verificar ownership)
 * @returns {Promise<boolean>} True si se marcó correctamente
 */
async function markAsRead(notificationId, userId) {
    try {
        const notification = await Notification.findOne({
            where: { id: notificationId, userId }
        });

        if (!notification) {
            throw new Error('Notification not found');
        }

        notification.isRead = true;
        await notification.save();

        return true;
    } catch (error) {
        logger.error(`[NotificationService] Error marking as read: ${error.message}`);
        throw error;
    }
}

module.exports = {
    createNotification,
    getNotifications,
    markAsRead
};

