/**
 * @fileoverview Routes for Voice Cloning and TTS.
 * Handles voice profile creation and audio generation.
 * @module routes/voice
 */
const express = require('express');
const voiceController = require('./voice.controller');
const authMiddleware = require('../../middleware/auth');
const { checkQuota } = require('../../middleware/quota.middleware');
const multer = require('multer');
const path = require('path');

const router = express.Router();

// Configure multer for file uploads
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/samples/')
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
        cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname))
    }
});

const upload = multer({
    storage: storage,
    limits: { fileSize: 10 * 1024 * 1024 }, // 10MB limit
    fileFilter: (req, file, cb) => {
        if (file.mimetype.startsWith('audio/')) {
            cb(null, true);
        } else {
            cb(new Error('Only audio files are allowed!'), false);
        }
    }
});

// Ensure uploads directory exists
const fs = require('fs');
const uploadDir = 'uploads/samples/';
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
}

router.use(authMiddleware.authenticate);

// POST /api/v1/voice/clone - Upload samples and clone voice
router.post('/clone',
    checkQuota('VOICE_CLONING'),
    upload.array('samples', 5), // Max 5 samples
    voiceController.cloneVoice
);

// POST /api/v1/voice/speak - Generate audio
router.post('/speak',
    checkQuota('TTS_GENERATION'),
    voiceController.speak
);

module.exports = router;

