const express = require('express');
const router = express.Router();
const audioController = require('./audio.controller');
const { authenticate } = require('../../middleware/auth');

/**
 * @fileoverview Rutas para la gestión de audio y TTS.
 * @module routes/audioRoutes
 */

// Rutas públicas (no requieren autenticación para escuchar)
/**
 * @route GET /api/v1/audio/post/:postId
 * @desc Obtiene el audio de un post (streaming).
 * @access Public
 */
router.get('/post/:postId', audioController.streamPostAudio);

/**
 * @route GET /api/v1/audio/voices
 * @desc Obtiene las voces disponibles.
 * @access Public
 */
router.get('/voices', audioController.getVoices);

// Rutas protegidas
router.delete('/post/:postId', authenticate, audioController.deletePostAudio);

module.exports = router;

