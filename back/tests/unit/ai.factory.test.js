const AIFactory = require('../../src/services/ai/ai.factory');
const logger = require('../../src/utils/logger');

// Mock Providers
jest.mock('../../src/services/ai/providers/openai.provider', () => {
    return jest.fn().mockImplementation(() => ({ name: 'OpenAI' }));
});
jest.mock('../../src/services/ai/providers/gemini.provider', () => {
    return jest.fn().mockImplementation(() => ({ name: 'Gemini' }));
});
jest.mock('../../src/services/ai/providers/elevenlabs.provider', () => {
    return jest.fn().mockImplementation(() => ({ name: 'ElevenLabs' }));
});

// Mock Logger
jest.mock('../../src/utils/logger', () => ({
    info: jest.fn(),
    warn: jest.fn(),
    error: jest.fn()
}));

describe('AIFactory', () => {
    const originalEnv = process.env;

    beforeEach(() => {
        jest.clearAllMocks();
        process.env = { ...originalEnv };
        // Reset singleton instance
        AIFactory.instance = null;
    });

    afterAll(() => {
        process.env = originalEnv;
    });

    describe('getProvider', () => {
        it('should return default provider (OpenAI) for text capability', () => {
            process.env.AI_PROVIDER = 'openai';
            const provider = AIFactory.getProvider('text');
            expect(provider.name).toBe('OpenAI');
        });

        it('should return Gemini provider if configured', () => {
            process.env.AI_PROVIDER = 'gemini';
            const provider = AIFactory.getProvider('text');
            expect(provider.name).toBe('Gemini');
        });

        it('should use fallback if default provider does not support capability', () => {
            process.env.AI_PROVIDER = 'gemini'; // Gemini doesn't support audio
            const provider = AIFactory.getProvider('audio');

            expect(logger.warn).toHaveBeenCalledWith(expect.stringContaining('fallback'));
            expect(provider.name).toBe('OpenAI'); // OpenAI supports audio
        });

        it('should respect specific overrides (AI_AUDIO_PROVIDER)', () => {
            process.env.AI_PROVIDER = 'openai';
            process.env.AI_AUDIO_PROVIDER = 'elevenlabs';

            const provider = AIFactory.getProvider('audio');
            expect(provider.name).toBe('ElevenLabs');
        });

        it('should throw error if capability is not supported by any provider', () => {
            // Mock capabilities inside the test if possible, or assume 'unknown' capability
            // Since capabilities are hardcoded in the class, we can try a fake capability
            // But the class logic checks hardcoded lists.
            // 'video' is not in any list.

            expect(() => AIFactory.getProvider('video')).toThrow('No provider available for capability: video');
        });
    });

    describe('Singleton', () => {
        it('should return the same instance', () => {
            const instance1 = new AIFactory();
            const instance2 = new AIFactory();
            expect(instance1).toBe(instance2);
        });
    });
});

