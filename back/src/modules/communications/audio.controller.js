const audioService = require('./audio.service');
const ttsService = require('./tts.service');
const logger = require('../../utils/logger');
const fs = require('fs');

/**
 * Genera y streamea audio para un post.
 */
async function streamPostAudio(req, res, next) {
    try {
        const { postId } = req.params;
        const voice = req.query.voice || 'alloy';

        // Validar voz
        const availableVoices = ttsService.getVoices();
        if (!availableVoices.includes(voice)) {
            return res.status(400).json({
                error: 'Invalid voice',
                availableVoices
            });
        }

        logger.info(`[AudioController] Streaming audio for post ${postId} with voice ${voice}`);

        // Obtener o generar audio
        const audioPath = await audioService.getPostAudio(postId, { voice });

        // Verificar que el archivo existe
        if (!fs.existsSync(audioPath)) {
            return res.status(404).json({ error: 'Audio file not found' });
        }

        // Obtener stats del archivo
        const stat = fs.statSync(audioPath);

        // Headers para streaming
        res.setHeader('Content-Type', 'audio/mpeg');
        res.setHeader('Content-Length', stat.size);
        res.setHeader('Accept-Ranges', 'bytes');
        res.setHeader('Cache-Control', 'public, max-age=604800'); // 7 días

        // Stream del archivo
        const readStream = fs.createReadStream(audioPath);
        readStream.pipe(res);

        readStream.on('error', (error) => {
            logger.error(`[AudioController] Error streaming audio: ${error.message}`);
            if (!res.headersSent) {
                res.status(500).json({ error: 'Error streaming audio' });
            }
        });
    } catch (error) {
        next(error);
    }
}

/**
 * Obtiene las voces disponibles.
 */
function getVoices(req, res) {
    const voices = ttsService.getVoices();
    res.status(200).json({
        voices,
        default: 'alloy'
    });
}

/**
 * Elimina el audio en caché de un post (solo el autor o admin).
 */
async function deletePostAudio(req, res, next) {
    try {
        const { postId } = req.params;
        const userId = req.user.id;

        // Verificar que el usuario es el autor del post o admin
        const post = await require('../repositories/post.repository').findById(postId);

        if (!post) {
            return res.status(404).json({ error: 'Post not found' });
        }

        // Asumimos que req.user tiene role (admin) o id
        const isAdmin = req.user.role === 'admin';
        const isAuthor = post.userId === userId;

        if (!isAuthor && !isAdmin) {
            return res.status(403).json({ error: 'Unauthorized to delete audio for this post' });
        }

        await audioService.deletePostAudio(postId);

        res.status(200).json({
            message: 'Audio cache cleared successfully'
        });
    } catch (error) {
        next(error);
    }
}

module.exports = {
    streamPostAudio,
    getVoices,
    deletePostAudio
};

