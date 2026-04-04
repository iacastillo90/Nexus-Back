const notificationService = require('./notification.service');
const logger = require('../../utils/logger');

/**
 * Obtiene las notificaciones del usuario autenticado.
 */
async function getNotifications(req, res, next) {
    try {
        const userId = req.user.id;
        const limit = parseInt(req.query.limit) || 20;

        const notifications = await notificationService.getNotifications(userId, limit);

        res.status(200).json({
            data: notifications,
            meta: {
                total: notifications.length
            }
        });
    } catch (error) {
        next(error);
    }
}

/**
 * Marca una notificación como leída.
 */
async function markAsRead(req, res, next) {
    try {
        const userId = req.user.id;
        const { id } = req.params;

        await notificationService.markAsRead(id, userId);

        res.status(200).json({
            message: 'Notification marked as read'
        });
    } catch (error) {
        next(error);
    }
}

module.exports = {
    getNotifications,
    markAsRead
};

