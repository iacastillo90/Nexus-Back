/**
 * @fileoverview Routes for Challenge management.
 * Handles listing, creating, and joining challenges.
 * @module routes/challenges
 */
const express = require('express');
const challengeController = require('./challenge.controller');
const authMiddleware = require('../../middleware/auth');

const router = express.Router();

router.use(authMiddleware.authenticate);

// GET /api/v1/challenges - List active challenges
router.get('/', challengeController.listChallenges);

// GET /api/v1/challenges/my - List user's challenges
router.get('/my', challengeController.getUserChallenges);

// POST /api/v1/challenges - Create challenge (Admin only - for now just auth)
router.post('/', challengeController.createChallenge);

// POST /api/v1/challenges/:challengeId/join - Join a challenge
router.post('/:challengeId/join', challengeController.joinChallenge);

module.exports = router;

