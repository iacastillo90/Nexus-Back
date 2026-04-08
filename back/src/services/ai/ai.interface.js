/**
 * Interfaz abstracta para proveedores de Inteligencia Artificial.
 * Garantiza que todos los proveedores implementen los mismos métodos.
 */
class AIProviderInterface {
    constructor() {
        if (this.constructor === AIProviderInterface) {
            throw new Error("AIProviderInterface cannot be instantiated directly.");
        }
    }

    /**
     * Genera un embedding vectorial para texto.
     * @param {string} text - Texto a vectorizar
     * @returns {Promise<number[]>} Array de números (vector)
     * @throws {Error} Abstract method
     */
    async generateEmbedding(text) {
        throw new Error("Method 'generateEmbedding' must be implemented.");
    }

    /**
     * Genera audio a partir de texto (TTS).
     * @param {string} text - Texto a convertir
     * @param {Object} options - Opciones de voz, velocidad, etc.
     * @returns {Promise<Buffer>} Buffer de audio
     * @throws {Error} Abstract method
     */
    async generateAudio(text, options) {
        throw new Error("Method 'generateAudio' must be implemented.");
    }

    /**
     * Genera texto/completions (Chat).
     * @param {string} systemPrompt - Instrucciones del sistema
     * @param {string} userPrompt - Input del usuario
     * @returns {Promise<string>} Respuesta de texto
     * @throws {Error} Abstract method
     */
    async generateText(systemPrompt, userPrompt) {
        throw new Error("Method 'generateText' must be implemented.");
    }
}

module.exports = AIProviderInterface;

