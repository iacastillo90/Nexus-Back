const express = require('express');
const userRoutes = require('../modules/users/user.routes');
const authRoutes = require('../modules/auth/auth.routes');
const postRoutes = require('../modules/content/post.routes');
const feedRoutes = require('../modules/content/feed.routes');
const searchRoutes = require('../modules/search/search.routes');
const notificationRoutes = require('../modules/notifications/notification.routes');
const voiceRoutes = require('../modules/communications/voice.routes');
const graphRoutes = require('../modules/communications/graph.routes');
const echoRoutes = require('../modules/communications/echo.routes');
const vibesRoutes = require('../modules/communications/vibes.routes');
const challengeRoutes = require('../modules/content/challenge.routes');
const dreamRoutes = require('../modules/content/dream.routes');
const verificationRoutes = require('../modules/verification/verification.routes');
const paymentRoutes = require('../modules/payments/payment.routes');

/**
 * @fileoverview Archivo principal de rutas de la API.
 * @module routes/index
 */

const router = express.Router();

// Rutas de Autenticación
router.use('/auth', authRoutes);

// Rutas para la entidad User
router.use('/users', userRoutes);

// Rutas para la entidad Post
router.use('/posts', postRoutes);

// Rutas para el Feed
router.use('/feed', feedRoutes);

// Rutas para Búsqueda Semántica
router.use('/search', searchRoutes);

// Rutas para Notificaciones
router.use('/notifications', notificationRoutes);

// Rutas para Audio/Voice
router.use('/voice', voiceRoutes);

// Rutas para Grafo 3D
router.use('/graph', graphRoutes);

// Rutas para Echo (Digital Twin)
router.use('/echo', echoRoutes);

// Rutas para Vibes Dashboard
router.use('/vibes', vibesRoutes);

// Rutas para Social Challenges
router.use('/challenges', challengeRoutes);

// Rutas para Dreams
router.use('/dreams', dreamRoutes);

// Rutas para Verificación de Contenido (Content DNA)
router.use('/verify', verificationRoutes);

// Rutas para Pagos (Stripe, PayPal, RevenueCat)
router.use('/payments', paymentRoutes);

module.exports = router;
