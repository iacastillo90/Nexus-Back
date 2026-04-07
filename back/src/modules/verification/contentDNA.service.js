const dnaUtils = require('../../utils/crypto/dna.utils');
const { ContentSignature } = require('../../models');
const { getRedisClient } = require('../../config/redis');
const logger = require('../../utils/logger');

/**
 * Content DNA Service - Cryptographic Authenticity.
 * 
 * Generates and verifies cryptographic signatures for content.
 * Ensures authenticity, traceability, and duplicate detection.
 * 
 * @module contentDNA.service
 */

/**
 * Generates a unique Content DNA for a new post.
 * 
 * @param {Object} content - Content metadata
 * @param {string} content.authorId
 * @param {string} content.contentText
 * @param {string} [content.mediaPath] - Path to uploaded file
 * @param {string} content.contentType - 'text', 'image', 'video'
 * @param {string} [content.parentId] - For replies/remixes
 * 
 * @returns {Promise<Object>} Generated DNA and metadata
 */
async function generateContentDNA(content) {
    const { authorId, contentText, mediaPath, contentType, parentId } = content;

    if (!authorId || (!contentText && !mediaPath)) {
        throw new Error('Invalid content for DNA generation');
    }

    try {
        const timestamp = Date.now();

        // 1. Delegar lógica de hash al util
        let mediaHash = null;
        if (mediaPath) {
            mediaHash = await dnaUtils.generateMediaHash(mediaPath);
        }

        const payload = dnaUtils.buildPayload({
            authorId,
            content: contentText,
            timestamp,
            mediaHash,
            contentType,
            parentId,
            secret: process.env.CONTENT_DNA_SECRET
        });

        const dnaHash = dnaUtils.calculateDNAHash(payload);

        // 2. Guardar en DB (Lógica de negocio pura)
        await ContentSignature.create({
            dnaHash,
            authorId,
            contentHash: crypto.createHash('sha256').update(contentText || '').digest('hex'),
            mediaHash,
            contentType: contentType || 'post', // Campo obligatorio
            parentId,
            timestamp,
            payload: payload.replace(process.env.CONTENT_DNA_SECRET, '[REDACTED]')
        });

        // 3. Guardar en Redis
        await cacheDNA(dnaHash, { authorId, timestamp, isValid: true });
        if (mediaHash) {
            await cacheMediaHash(mediaHash, dnaHash);
        }

        logger.info(`[ContentDNA] Generated DNA: ${dnaHash}`);

        return {
            dnaHash,
            timestamp,
            mediaHash
        };

    } catch (error) {
        logger.error('[ContentDNA] Failed:', error);
        throw error;
    }
}

/**
 * Verifies if a Content DNA is valid.
 * 
 * @param {string} dnaHash 
 * @returns {Promise<Object>} Verification result
 */
async function verifyContentDNA(dnaHash) {
    try {
        // 1. Check Cache
        const cached = await getCachedDNA(dnaHash);
        if (cached) {
            return { isValid: true, source: 'cache', ...cached };
        }

        // 2. Check DB
        const signature = await ContentSignature.findOne({ where: { dnaHash } });
        if (!signature) {
            return { isValid: false, reason: 'DNA not found' };
        }

        return {
            isValid: true,
            source: 'database',
            authorId: signature.authorId,
            timestamp: signature.timestamp
        };

    } catch (error) {
        logger.error(`[ContentDNA] Verification error: ${error.message}`);
        return { isValid: false, error: error.message };
    }
}

/**
 * Checks if media has already been uploaded.
 * 
 * @param {string} filePath 
 * @returns {Promise<Object>} Duplicate info
 */
async function detectDuplicateMedia(filePath) {
    try {
        const mediaHash = await dnaUtils.generateMediaHash(filePath);

        // Check Redis for Media Hash
        const redis = await getRedisClient();
        const existingDna = await redis.get(`media:${mediaHash}`);

        if (existingDna) {
            return { isDuplicate: true, originalDna: existingDna };
        }

        // Check DB
        const existing = await ContentSignature.findOne({ where: { mediaHash } });
        if (existing) {
            // Cache it for future
            await cacheMediaHash(mediaHash, existing.dnaHash);
            return { isDuplicate: true, originalDna: existing.dnaHash };
        }

        return { isDuplicate: false, mediaHash };

    } catch (error) {
        logger.error(`[ContentDNA] Duplicate check error: ${error.message}`);
        throw error;
    }
}

// --- Private Helpers ---

async function cacheDNA(dnaHash, data) {
    try {
        const redis = await getRedisClient();
        await redis.setEx(`dna:${dnaHash}`, 86400, JSON.stringify(data)); // 24h cache
    } catch (e) {
        logger.warn('[ContentDNA] Redis cache failed');
    }
}

async function getCachedDNA(dnaHash) {
    try {
        const redis = await getRedisClient();
        const data = await redis.get(`dna:${dnaHash}`);
        return data ? JSON.parse(data) : null;
    } catch (e) {
        return null;
    }
}

async function cacheMediaHash(mediaHash, dnaHash) {
    try {
        const redis = await getRedisClient();
        await redis.set(`media:${mediaHash}`, dnaHash);
    } catch (e) {
        logger.warn('[ContentDNA] Redis media cache failed');
    }
}

// Need crypto for the contentHash in create (it wasn't moved to utils in the prompt but is simple enough)
const crypto = require('crypto');

module.exports = {
    generateContentDNA,
    verifyContentDNA,
    detectDuplicateMedia
};

