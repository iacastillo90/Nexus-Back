const OpenAIProvider = require('./providers/openai.provider');
const GeminiProvider = require('./providers/gemini.provider');
const ElevenLabsProvider = require('./providers/elevenlabs.provider');
const logger = require('../../utils/logger');

/**
 * Fábrica de proveedores de IA.
 * 
 * Implementa el patrón Singleton y Factory para gestionar
 * instancias de proveedores de IA (OpenAI, Gemini, ElevenLabs).
 * 
 * Maneja la lógica de selección de proveedor basada en configuración
 * y capacidades requeridas (fallback automático).
 */
class AIFactory {
    constructor() {
        if (!AIFactory.instance) {
            this.providers = {};
            AIFactory.instance = this;
        }
        return AIFactory.instance;
    }

    /**
     * Obtiene el provider adecuado según la capacidad requerida.
     * 
     * Implementa lógica de fallback automático:
     * - Si capability='audio' y provider principal no soporta TTS → fallback
     * - Si capability='embeddings' → usa provider configurado
     * - Si capability='text' → usa provider configurado
     * 
     * @param {string} capability - 'embeddings' | 'text' | 'audio'
     * @returns {AIProviderInterface} Provider adecuado
     */
    static getProvider(capability = 'text') {
        try {
            const { config } = require('../../config');
            const instance = new AIFactory();
            const defaultProvider = config.ai.provider;

            // Mapa de capacidades por provider
            const capabilities = {
                openai: ['embeddings', 'text', 'audio'],
                gemini: ['embeddings', 'text'],
                elevenlabs: ['audio']
            };

            // 1. Check specific overrides first (e.g. AI_AUDIO_PROVIDER)
            if (capability === 'audio' && config.ai.audioProvider === 'elevenlabs') {
                return instance._getOrInstantiate('elevenlabs');
            }

            // 2. Check if default provider supports capability
            if (capabilities[defaultProvider] && capabilities[defaultProvider].includes(capability)) {
                return instance._getOrInstantiate(defaultProvider);
            }

            // 3. Fallback: Find first provider that supports capability
            logger.warn(`[AIFactory] ${defaultProvider} does not support ${capability}, attempting fallback...`);

            const fallbackProviderName = Object.keys(capabilities).find(p =>
                capabilities[p].includes(capability)
            );

            if (!fallbackProviderName) {
                throw new Error(`No provider available for capability: ${capability}`);
            }

            logger.info(`[AIFactory] Using fallback provider ${fallbackProviderName} for ${capability}`);
            return instance._getOrInstantiate(fallbackProviderName);
        } catch (error) {
            logger.error(`[AIFactory] Critical Error getting provider: ${error.message}`);
            // Fallback de emergencia o re-lanzar error tipado
            throw new Error('AI Service Unavailable: Configuration Error');
        }
    }

    _getOrInstantiate(providerName) {
        try {
            if (!this.providers[providerName]) {
                switch (providerName) {
                    case 'openai':
                        this.providers[providerName] = new OpenAIProvider();
                        break;
                    case 'gemini':
                        this.providers[providerName] = new GeminiProvider();
                        break;
                    case 'elevenlabs':
                        this.providers[providerName] = new ElevenLabsProvider();
                        break;
                    default:
                        throw new Error(`Unsupported AI provider: ${providerName}`);
                }
            }
            return this.providers[providerName];
        } catch (error) {
            logger.error(`[AIFactory] Failed to instantiate ${providerName}: ${error.message}`);
            throw error;
        }
    }
}

module.exports = AIFactory;

