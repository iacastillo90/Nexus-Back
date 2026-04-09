const AIProviderInterface = require('../ai.interface');
const axios = require('axios');
const { ExternalAPIError } = require('../../../utils/errors');
const logger = require('../../../utils/logger');

class ElevenLabsProvider extends AIProviderInterface {
    constructor() {
        super();
        const { config } = require('../../../config');
        this.apiKey = config.ai.elevenlabsKey;
        this.baseUrl = 'https://api.elevenlabs.io/v1';
    }

    async generateEmbedding(text) {
        throw new Error("ElevenLabs does not support text embeddings.");
    }

    async generateText(systemPrompt, userPrompt) {
        throw new Error("ElevenLabs does not support text generation.");
    }

    /**
     * Generates audio from text using ElevenLabs.
     * @param {string} text - Text to synthesize
     * @param {Object} options - Options (voiceId, modelId, stability, similarity_boost)
     * @returns {Promise<Buffer>} Audio buffer
     */
    async generateAudio(text, options = {}) {
        try {
            const voiceId = options.voiceId || '21m00Tcm4TlvDq8ikWAM'; // Default voice (Rachel)
            const modelId = options.modelId || 'eleven_monolingual_v1';

            const response = await axios.post(
                `${this.baseUrl}/text-to-speech/${voiceId}`,
                {
                    text,
                    model_id: modelId,
                    voice_settings: {
                        stability: options.stability || 0.5,
                        similarity_boost: options.similarityBoost || 0.5
                    }
                },
                {
                    headers: {
                        'xi-api-key': this.apiKey,
                        'Content-Type': 'application/json',
                        'Accept': 'audio/mpeg'
                    },
                    responseType: 'arraybuffer'
                }
            );

            return Buffer.from(response.data);
        } catch (error) {
            logger.error(`[ElevenLabs] Error generating audio: ${error.message}`);
            throw new ExternalAPIError('ElevenLabs TTS failed');
        }
    }

    /**
     * Clona una voz usando muestras de audio del usuario.
     * 
     * Proceso:
     * 1. Valida archivos de audio (existencia y formato)
     * 2. Lee archivos como buffers
     * 3. Llama a ElevenLabs API /v1/voices/add
     * 4. Retorna voice_id generado
     * 
     * @param {string} name - Nombre descriptivo de la voz
     * @param {string[]} samplePaths - Rutas a archivos de audio (1-3 archivos)
     *                                  Formatos: .mp3, .wav, .m4a
     *                                  Duración mínima: 30s por archivo
     * 
     * @returns {Promise<string>} voice_id generado por ElevenLabs
     * 
     * @throws {ValidationError} Si archivos no existen o formato inválido
     * @throws {ExternalAPIError} Si ElevenLabs API falla
     * @throws {RateLimitError} Si se excede límite de clonaciones
     */
    async addVoice(name, samplePaths) {
        const fs = require('fs');
        const FormData = require('form-data');
        const { ValidationError } = require('../../../utils/errors');

        if (!samplePaths || samplePaths.length === 0) {
            throw new ValidationError('At least one audio sample is required');
        }

        const form = new FormData();
        form.append('name', name);
        // Default description and labels
        form.append('description', `Cloned voice for ${name}`);
        // form.append('labels', JSON.stringify({ accent: 'neutral' })); 

        try {
            for (const path of samplePaths) {
                if (!fs.existsSync(path)) {
                    throw new ValidationError(`Audio sample not found: ${path}`);
                }
                // Basic extension check
                if (!path.match(/\.(mp3|wav|m4a)$/i)) {
                    throw new ValidationError(`Invalid audio format: ${path}. Allowed: mp3, wav, m4a`);
                }
                form.append('files', fs.createReadStream(path));
            }

            logger.info(`[ElevenLabs] Cloning voice "${name}" with ${samplePaths.length} samples`);

            const response = await axios.post(
                `${this.baseUrl}/voices/add`,
                form,
                {
                    headers: {
                        ...form.getHeaders(),
                        'xi-api-key': this.apiKey
                    }
                }
            );

            const voiceId = response.data.voice_id;
            logger.info(`[ElevenLabs] Voice cloned successfully: ${voiceId}`);
            return voiceId;

        } catch (error) {
            if (error instanceof ValidationError) {
                throw error;
            }
            logger.error(`[ElevenLabs] Error cloning voice: ${error.message}`);
            if (error.response) {
                logger.error(`[ElevenLabs] API Error: ${JSON.stringify(error.response.data)}`);
                if (error.response.status === 429) {
                    throw new Error('Rate limit exceeded for voice cloning'); // Should be RateLimitError if imported
                }
            }
            throw new ExternalAPIError('ElevenLabs Voice Cloning failed');
        }
    }
}

module.exports = ElevenLabsProvider;

