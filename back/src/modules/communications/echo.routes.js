/**
 * @fileoverview Routes for Echo (AI) features.
 * Handles predictions, auto-replies, and summarization.
 * @module routes/echo
 */
const express = require('express');
const echoController = require('./echo.controller');
const authMiddleware = require('../../middleware/auth');
const { cacheMiddleware } = require('../../middleware/cache');
const { validateEchoRequest } = require('../../middleware/validators/echo.validator');
const { checkQuota } = require('../../middleware/quota.middleware');

const router = express.Router();

// Todas las rutas requieren autenticación
router.use(authMiddleware.authenticate);

// POST /api/echo/predict - Predecir reacción (sin caché, siempre fresh)
router.post('/predict',
    validateEchoRequest,
    checkQuota('ECHO_PREDICTIONS'),
    echoController.predictReaction
);

// POST /api/echo/auto-reply - Generar respuesta automática
router.post('/auto-reply',
    validateEchoRequest,
    checkQuota('AUTO_REPLY'),
    echoController.autoReply
);

// GET /api/echo/summarize/:postId - Resumir hilo (con caché 5 min)
router.get('/summarize/:postId',
    // No quota for reading summaries? Or maybe yes. Let's assume no for now or low cost.
    // Actually, summarization uses tokens. Let's add quota.
    checkQuota('ECHO_PREDICTIONS'), // Reusing prediction quota or add new one
    cacheMiddleware((req) => `echo:summary:${req.params.postId}:${req.user.id}`, 300),
    echoController.summarizeComments
);

module.exports = router;

