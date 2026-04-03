/**
 * @fileoverview Routes for Dream management.
 * Handles creating and contributing to collaborative dreams.
 * @module routes/dreams
 */
const express = require('express');
const dreamController = require('./dream.controller');
const { authenticate } = require('../../middleware/auth');

const router = express.Router();

// POST /api/v1/dreams - Crear un nuevo sueño
router.post('/', authenticate, dreamController.createDream);

// POST /api/v1/dreams/:id/contribute - Contribuir a un sueño
router.post('/:id/contribute', authenticate, dreamController.addContribution);

// GET /api/v1/dreams/:id - Obtener estado del sueño
router.get('/:id', authenticate, dreamController.getDream);

module.exports = router;

