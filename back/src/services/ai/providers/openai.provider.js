const OpenAI = require('openai');
const AIProviderInterface = require('../ai.interface');
const logger = require('../../../utils/logger');
const { ExternalAPIError } = require('../../../utils/errors');

class OpenAIProvider extends AIProviderInterface {
    constructor() {
        super();
        const { config } = require('../../../config');
        if (!OpenAIProvider.instance) {
            this.client = new OpenAI({
                apiKey: config.ai.openaiKey,
            });
            OpenAIProvider.instance = this;
        }
        return OpenAIProvider.instance;
    }

    /**
     * Genera un embedding vectorial para texto.
     * 
     * Convierte texto en representación vectorial de 1536 dimensiones
     * que captura significado semántico. Usado para búsqueda semántica
     * y comparación de similitud.
     * 
     * Límites:
     * - Máximo 8,000 tokens (~32,000 caracteres)
     * - Costo: ~$0.02 por 1M tokens
     * 
     * @param {string} text - Texto a vectorizar
     * @returns {Promise<number[]>} Array de 1536 números flotantes
     * 
     * @throws {ExternalAPIError} Si OpenAI API falla
     * 
     * @example
     * const emb = await provider.generateEmbedding('Hello world');
     * // => [0.123, -0.456, 0.789, ...]
     */
    async generateEmbedding(text) {
        try {
            // Limpiar texto básico
            const cleanText = text.replace(/\n/g, ' ');
            const response = await this.client.embeddings.create({
                model: 'text-embedding-3-small', // 1536 dimensiones
                input: cleanText,
                encoding_format: 'float',
            });
            return response.data[0].embedding;
        } catch (error) {
            logger.error(`[OpenAIProvider] Embedding error: ${error.message}`);
            throw new ExternalAPIError('OpenAI Embedding failed');
        }
    }

    /**
     * Genera audio a partir de texto (TTS).
     * 
     * Utiliza el modelo TTS de OpenAI para sintetizar voz.
     * 
     * @param {string} text - Texto a sintetizar
     * @param {Object} [options] - Opciones de configuración
     * @param {string} [options.model='tts-1'] - Modelo a usar (tts-1, tts-1-hd)
     * @param {string} [options.voice='alloy'] - Voz a usar (alloy, echo, fable, onyx, nova, shimmer)
     * @param {number} [options.speed=1.0] - Velocidad de reproducción (0.25 a 4.0)
     * 
     * @returns {Promise<Buffer>} Buffer de audio en formato MP3
     * 
     * @throws {ExternalAPIError} Si OpenAI API falla
     * 
     * @example
     * const audio = await provider.generateAudio('Hello world', { voice: 'nova' });
     */
    async generateAudio(text, options = {}) {
        try {
            const response = await this.client.audio.speech.create({
                model: options.model || 'tts-1',
                voice: options.voice || 'alloy',
                input: text,
                speed: options.speed || 1.0,
                response_format: 'mp3'
            });
            return Buffer.from(await response.arrayBuffer());
        } catch (error) {
            logger.error(`[OpenAIProvider] TTS error: ${error.message}`);
            throw new ExternalAPIError('OpenAI TTS failed');
        }
    }

    /**
     * Genera texto completando un prompt (Chat Completion).
     * 
     * @param {string} systemPrompt - Instrucciones del sistema
     * @param {string} userPrompt - Input del usuario
     * @returns {Promise<string>} Texto generado
     * 
     * @throws {ExternalAPIError} Si OpenAI API falla
     * 
     * @example
     * const text = await provider.generateText('You are a helpful assistant', 'Tell me a joke');
     */
    async generateText(systemPrompt, userPrompt) {
        try {
            const { config } = require('../../../config');
            const response = await this.client.chat.completions.create({
                model: 'gpt-4o-mini',
                messages: [
                    { role: 'system', content: systemPrompt },
                    { role: 'user', content: userPrompt }
                ],
            });
            return response.choices[0].message.content;
        } catch (error) {
            logger.error(`[OpenAIProvider] Chat error: ${error.message}`);
            throw new ExternalAPIError('OpenAI Chat failed');
        }
    }
}

module.exports = OpenAIProvider;

