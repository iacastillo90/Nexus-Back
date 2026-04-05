const express = require('express');
const router = express.Router();
const notificationController = require('./notification.controller');
const { authenticate } = require('../../middleware/auth');

/**
 * @fileoverview Rutas para la gestión de notificaciones.
 * @module routes/notificationRoutes
 */

// Todas las rutas requieren autenticación
router.use(authenticate);

/**
 * @route GET /api/v1/notifications
 * @desc Obtiene las notificaciones del usuario autenticado.
 * @access Private
 */
router.get('/', notificationController.getNotifications);

/**
 * @route PATCH /api/v1/notifications/:id/read
 * @desc Marca una notificación como leída.
 * @access Private
 */
router.patch('/:id/read', notificationController.markAsRead);

module.exports = router;

