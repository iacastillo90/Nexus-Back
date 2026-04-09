const { GoogleGenerativeAI } = require("@google/generative-ai");
const AIProviderInterface = require('../ai.interface');
const logger = require('../../../utils/logger');
const { ExternalAPIError } = require('../../../utils/errors');

class GeminiProvider extends AIProviderInterface {
    constructor() {
        super();
        const { config } = require('../../../config');
        this.genAI = new GoogleGenerativeAI(config.ai.geminiKey);
    }

    /**
     * Genera un embedding vectorial para texto usando Gemini.
     * 
     * Utiliza el modelo embedding-001 de Google para convertir texto
     * en vectores.
     * 
     * @param {string} text - Texto a vectorizar
     * @returns {Promise<number[]>} Array de números flotantes
     * 
     * @throws {ExternalAPIError} Si Gemini API falla
     * 
     * @example
     * const emb = await provider.generateEmbedding('Hello world');
     */
    async generateEmbedding(text) {
        try {
            const model = this.genAI.getGenerativeModel({ model: "embedding-001" });
            const cleanText = text.replace(/\n/g, ' ');
            const result = await model.embedContent(cleanText);
            // Gemini devuelve 'values', nosotros devolvemos el array directo
            return result.embedding.values;
        } catch (error) {
            logger.error(`[GeminiProvider] Embedding error: ${error.message}`);
            throw new ExternalAPIError('Gemini Embedding failed');
        }
    }

    /**
     * Genera texto usando Gemini Pro.
     * 
     * @param {string} systemPrompt - Instrucciones del sistema
     * @param {string} userPrompt - Input del usuario
     * @returns {Promise<string>} Texto generado
     * 
     * @throws {ExternalAPIError} Si Gemini API falla
     * 
     * @example
     * const text = await provider.generateText('System instruction', 'User input');
     */
    async generateText(systemPrompt, userPrompt) {
        try {
            const model = this.genAI.getGenerativeModel({ model: "gemini-pro" });
            // Gemini maneja system prompts un poco diferente, pero podemos concatenar o usar instrucciones
            const prompt = `${systemPrompt}\n\nUser: ${userPrompt}`;
            const result = await model.generateContent(prompt);
            const response = await result.response;
            return response.text();
        } catch (error) {
            logger.error(`[GeminiProvider] Chat error: ${error.message}`);
            throw new ExternalAPIError('Gemini Chat failed');
        }
    }

    /**
     * Genera audio (No implementado en Gemini).
     * 
     * @throws {Error} Siempre lanza error ya que Gemini no soporta TTS nativamente en esta SDK
     */
    async generateAudio(text, options) {
        throw new Error("Gemini TTS not implemented yet. Use OpenAI or ElevenLabs provider.");
    }
}

module.exports = GeminiProvider;

