const express = require('express');
const verificationController = require('./verification.controller');
const authMiddleware = require('../../middleware/auth');
const upload = require('../../middleware/upload'); // Multer config
const { cacheMiddleware } = require('../../middleware/cache');

const router = express.Router();

/**
 * GET /api/verify/:dnaHash
 * Verify content authenticity (public, no auth)
 * Cache: 1 hour (verifications don't change)
 */
router.get('/:dnaHash',
    cacheMiddleware((req) => `verify:${req.params.dnaHash}`, 3600),
    verificationController.verifyContent
);

/**
 * POST /api/verify/media
 * Verify if media is duplicate (requires auth)
 * No cache (each file is unique)
 */
router.post('/media',
    authMiddleware.authenticate,
    upload.single('media'),
    verificationController.checkMediaDuplicate
);

module.exports = router;

