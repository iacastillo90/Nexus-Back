const crypto = require('crypto');
const fs = require('fs').promises;

/**
 * Genera un hash SHA-256 para el payload del DNA.
 */
function calculateDNAHash(payload) {
    return crypto.createHash('sha256').update(payload).digest('hex');
}

/**
 * Construye el payload string inmutable.
 */
function buildPayload({ authorId, content, timestamp, mediaHash, contentType, parentId, secret }) {
    return [
        authorId,
        content || '',
        timestamp.toString(),
        mediaHash || '',
        contentType,
        parentId || '',
        secret
    ].join('::');
}

/**
 * Genera hash de un archivo de media.
 */
async function generateMediaHash(filePath) {
    try {
        const fileBuffer = await fs.readFile(filePath);
        return crypto.createHash('sha256').update(fileBuffer).digest('hex');
    } catch (error) {
        throw new Error(`Failed to hash media file: ${error.message}`);
    }
}

module.exports = { calculateDNAHash, buildPayload, generateMediaHash };

