const express = require('express');
const feedController = require('./feed.controller');
const { authenticate } = require('../../middleware/auth');
const { cacheMiddleware } = require('../../middleware/cache');

/**
 * @fileoverview Rutas para el Feed de noticias.
 * @module routes/feedRoutes
 */

const router = express.Router();

/**
 * @route GET /api/v1/feed
 * @desc Obtiene el feed personalizado del usuario.
 * @access Private
 * @cache feed:{userId}:page:{page} (60s)
 */
// GET /api/v1/feed - Obtener feed personalizado
// Cache Key: feed:{userId}:page:{page}
// TTL: 60 segundos
router.get('/',
    authenticate,
    cacheMiddleware((req) => `feed:${req.user.id}:page:${req.query.page || 1}`, 60),
    feedController.getFeed
);

// GET /api/v1/feed/neuro - Obtener Neuro-Feed (Personalizado por Vibe)
// No cacheamos agresivamente porque depende del vibe actual
router.get('/neuro',
    authenticate,
    feedController.getNeuroFeed
);

module.exports = router;

