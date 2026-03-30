const express = require('express');
const router = express.Router();
const graphController = require('./graph.controller');
const { authenticate } = require('../../middleware/auth');

/**
 * @fileoverview Rutas para el grafo social y métricas.
 * @module routes/graphRoutes
 */

// Rutas públicas (para visualización)
/**
 * @route GET /api/v1/graph/network
 * @desc Obtiene el grafo completo de la red.
 * @access Public
 */
router.get('/network', graphController.getNetworkGraph);

/**
 * @route GET /api/v1/graph/user/:userId/neighborhood
 * @desc Obtiene el vecindario (conexiones cercanas) de un usuario.
 * @access Public
 */
router.get('/user/:userId/neighborhood', graphController.getUserNeighborhood);

/**
 * @route GET /api/v1/graph/influencers
 * @desc Obtiene los usuarios más influyentes.
 * @access Public
 */
router.get('/influencers', graphController.getInfluentialUsers);

module.exports = router;

