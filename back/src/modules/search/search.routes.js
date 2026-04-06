const express = require('express');
const router = express.Router();
const searchController = require('./search.controller');
const { authenticate } = require('../../middleware/auth');

/**
 * @fileoverview Rutas para la búsqueda semántica.
 * @module routes/searchRoutes
 */

// Todas las rutas de búsqueda requieren autenticación
router.use(authenticate);

/**
 * @route GET /api/v1/search
 * @desc Realiza una búsqueda semántica de posts.
 * @access Private
 */
router.get('/', searchController.searchPosts);

module.exports = router;

