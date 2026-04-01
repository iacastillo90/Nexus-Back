const AIFactory = require('./ai/ai.factory');
const fs = require('fs');
const path = require('path');
const logger = require('../../utils/logger');
const { ExternalAPIError } = require('../../utils/errors');

// Voces disponibles en OpenAI TTS (se mantienen como referencia, aunque el provider puede tener otras)
const AVAILABLE_VOICES = ['alloy', 'echo', 'fable', 'onyx', 'nova', 'shimmer'];

/**
 * Genera audio a partir de texto usando el proveedor configurado.
 * @param {string} text - Texto a convertir en audio
 * @param {Object} options - Opciones de generación
 * @param {string} options.voice - Voz a usar (default: 'alloy')
 * @param {string} options.model - Modelo TTS (default: 'tts-1')
 * @param {number} options.speed - Velocidad (0.25 - 4.0, default: 1.0)
 * @returns {Promise<Buffer>} Buffer con el audio en formato MP3
 */
async function generateAudio(text, options = {}) {
    try {
        if (!text || text.trim().length === 0) {
            throw new Error('Text is required for audio generation');
        }

        const provider = AIFactory.getProvider();

        // Validar voz si es OpenAI (esto podría moverse al provider específico, pero lo dejamos aquí por compatibilidad)
        if (options.voice && !AVAILABLE_VOICES.includes(options.voice)) {
            // Nota: Si cambiamos de provider, esta validación podría fallar si las voces son diferentes.
            // Idealmente, el provider debería exponer getVoices().
            // Por ahora, asumimos que si se pasa una voz, es válida o el provider la manejará.
        }

        logger.info(`[TTSService] Generating audio for ${text.length} characters`);

        const buffer = await provider.generateAudio(text, options);

        logger.info(`[TTSService] Audio generated successfully (${buffer.length} bytes)`);
        return buffer;
    } catch (error) {
        logger.error(`[TTSService] Error generating audio: ${error.message}`);
        throw new ExternalAPIError(`Failed to generate audio: ${error.message}`);
    }
}

/**
 * Obtiene la lista de voces disponibles.
 * @returns {string[]} Lista de voces
 */
function getVoices() {
    return AVAILABLE_VOICES;
}

module.exports = {
    generateAudio,
    getVoices
};

