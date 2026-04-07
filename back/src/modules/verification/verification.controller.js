const contentDNAService = require('./contentDNA.service');
const logger = require('../../utils/logger');

/**
 * Handler: GET /api/verify/:dnaHash
 * Verifies content authenticity by its DNA Hash.
 * 
 * Public endpoint (no auth required) so anyone can verify
 * if content is original to Nexus.
 * 
 * Request:
 * - Params: :dnaHash (64 hex chars)
 * 
 * Response:
 * - 200: { success: true, isValid: true, metadata: {...} }
 * - 404: { success: false, isValid: false, message: 'Content not found' }
 * - 400: { success: false, error: 'Invalid hash format' }
 * 
 * @param {Request} req - Express request
 * @param {Response} res - Express response
 * @param {NextFunction} next - Express next
 */
async function verifyContent(req, res, next) {
    try {
        const { dnaHash } = req.params;

        logger.info('[VerificationController] Verifying content', {
            dnaHash: dnaHash.substring(0, 16) + '...',
            ip: req.ip
        });

        const result = await contentDNAService.verifyContentDNA(dnaHash);

        if (!result.isValid) {
            return res.status(404).json({
                success: false,
                isValid: false,
                message: 'This content is not verified in Nexus. It may be fake or modified.'
            });
        }

        res.json({
            success: true,
            isValid: true,
            metadata: result.metadata,
            verifiedAt: new Date()
        });

    } catch (error) {
        next(error);
    }
}

/**
 * Handler: POST /api/verify/media
 * Checks if a media file already exists in Nexus.
 * 
 * Useful to detect content theft before posting.
 * 
 * Request:
 * - Body: multipart/form-data with field 'media' (file)
 * - Headers: Authorization (requires auth)
 * 
 * Response:
 * - 200: { isDuplicate: false }
 * - 200: { isDuplicate: true, matches: [...] }
 * 
 * @param {Request} req - Express request with file
 * @param {Response} res - Express response
 * @param {NextFunction} next - Express next
 */
async function checkMediaDuplicate(req, res, next) {
    try {
        if (!req.file) {
            return res.status(400).json({
                success: false,
                error: 'No media file provided'
            });
        }

        const mediaPath = req.file.path;

        logger.info('[VerificationController] Checking media duplicate', {
            userId: req.user.id,
            filename: req.file.originalname
        });

        const result = await contentDNAService.detectDuplicateMedia(mediaPath);

        res.json({
            success: true,
            isDuplicate: result.isDuplicate,
            ...(result.isDuplicate && { matches: result.matches })
        });

    } catch (error) {
        next(error);
    }
}

module.exports = {
    verifyContent,
    checkMediaDuplicate
};

