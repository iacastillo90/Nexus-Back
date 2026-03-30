const fs = require('fs').promises;
const path = require('path');
const crypto = require('crypto');
const ttsService = require('./tts.service');
const postRepository = require('../repositories/post.repository');
const logger = require('../../utils/logger');
const { NotFoundError } = require('../../utils/errors');

const AUDIO_DIR = path.join(__dirname, '../../public/audio');
const CACHE_TTL_DAYS = 7;

/**
 * Genera un nombre de archivo único para el audio.
 * @param {string} postId - ID del post
 * @param {string} voice - Voz usada
 * @returns {string} Nombre del archivo
 */
function getAudioFilename(postId, voice = 'alloy') {
    return `${postId}_${voice}.mp3`;
}

/**
 * Verifica si el audio está en caché y es válido.
 * @param {string} filename - Nombre del archivo
 * @returns {Promise<boolean>} True si existe y es válido
 */
async function isCached(filename) {
    try {
        const filePath = path.join(AUDIO_DIR, filename);
        const stats = await fs.stat(filePath);

        // Verificar si el archivo no ha expirado
        const ageInDays = (Date.now() - stats.mtimeMs) / (1000 * 60 * 60 * 24);
        if (ageInDays > CACHE_TTL_DAYS) {
            // Archivo expirado, eliminarlo
            await fs.unlink(filePath);
            return false;
        }

        return true;
    } catch (error) {
        return false;
    }
}

/**
 * Genera audio para un post (con caché).
 * @param {string} postId - ID del post
 * @param {Object} options - Opciones de generación
 * @returns {Promise<string>} Path al archivo de audio
 */
async function generatePostAudio(postId, options = {}) {
    try {
        const voice = options.voice || 'alloy';
        const filename = getAudioFilename(postId, voice);
        const filePath = path.join(AUDIO_DIR, filename);

        // Verificar caché
        if (await isCached(filename)) {
            logger.info(`[AudioService] Using cached audio for post ${postId}`);
            return filePath;
        }

        // Obtener contenido del post
        const post = await postRepository.findById(postId);
        if (!post) {
            throw new NotFoundError('Post not found');
        }

        if (!post.content || post.content.trim().length === 0) {
            throw new Error('Post has no content to convert to audio');
        }

        logger.info(`[AudioService] Generating new audio for post ${postId}`);

        // Generar audio
        const audioBuffer = await ttsService.generateAudio(post.content, options);

        // Asegurar que el directorio existe
        await fs.mkdir(AUDIO_DIR, { recursive: true });

        // Guardar archivo
        await fs.writeFile(filePath, audioBuffer);

        logger.info(`[AudioService] Audio saved to ${filePath}`);
        return filePath;
    } catch (error) {
        logger.error(`[AudioService] Error generating post audio: ${error.message}`);
        throw error;
    }
}

/**
 * Obtiene el audio de un post (genera si no existe).
 * @param {string} postId - ID del post
 * @param {Object} options - Opciones de generación
 * @returns {Promise<string>} Path al archivo de audio
 */
async function getPostAudio(postId, options = {}) {
    return await generatePostAudio(postId, options);
}

/**
 * Elimina el audio en caché de un post.
 * @param {string} postId - ID del post
 */
async function deletePostAudio(postId) {
    try {
        const voices = ttsService.getVoices();

        // Eliminar todas las versiones (diferentes voces)
        for (const voice of voices) {
            const filename = getAudioFilename(postId, voice);
            const filePath = path.join(AUDIO_DIR, filename);

            try {
                await fs.unlink(filePath);
                logger.info(`[AudioService] Deleted cached audio: ${filename}`);
            } catch (error) {
                // Archivo no existe, ignorar
            }
        }
    } catch (error) {
        logger.error(`[AudioService] Error deleting post audio: ${error.message}`);
    }
}

/**
 * Limpia archivos de audio expirados.
 */
async function cleanExpiredAudio() {
    try {
        const files = await fs.readdir(AUDIO_DIR);
        let cleaned = 0;

        for (const file of files) {
            if (file.endsWith('.mp3')) {
                const filePath = path.join(AUDIO_DIR, file);
                const stats = await fs.stat(filePath);
                const ageInDays = (Date.now() - stats.mtimeMs) / (1000 * 60 * 60 * 24);

                if (ageInDays > CACHE_TTL_DAYS) {
                    await fs.unlink(filePath);
                    cleaned++;
                }
            }
        }

        if (cleaned > 0) {
            logger.info(`[AudioService] Cleaned ${cleaned} expired audio files`);
        }
    } catch (error) {
        logger.error(`[AudioService] Error cleaning expired audio: ${error.message}`);
    }
}

module.exports = {
    generatePostAudio,
    getPostAudio,
    deletePostAudio,
    cleanExpiredAudio
};

