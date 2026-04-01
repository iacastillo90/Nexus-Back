/**
 * @fileoverview Routes for Vibes (Sentiment Analysis).
 * Handles user dashboard and community vibe trends.
 * @module routes/vibes
 */
const express = require('express');
const vibesController = require('./vibes.controller');
const authMiddleware = require('../../middleware/auth');
const { checkQuota } = require('../../middleware/quota.middleware');

const router = express.Router();

router.use(authMiddleware.authenticate);

// GET /api/v1/vibes/dashboard - User's emotional dashboard
router.get('/dashboard',
    vibesController.getDashboard
);

// GET /api/v1/vibes/community - Global community trends
router.get('/community',
    vibesController.getCommunityVibes
);

module.exports = router;

