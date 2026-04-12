const request = require('supertest');
const app = require('../../src/app');
const AIFactory = require('../../src/services/ai/ai.factory');
const OpenAIProvider = require('../../src/services/ai/providers/openai.provider');
const GeminiProvider = require('../../src/services/ai/providers/gemini.provider');

// Mock external SDKs
jest.mock('openai', () => {
    return class OpenAI {
        constructor(options) {
            if (!options.apiKey) throw new Error('Missing credentials');
            this.embeddings = { create: jest.fn() };
            this.audio = { speech: { create: jest.fn() } };
            this.chat = { completions: { create: jest.fn() } };
        }
    };
});

jest.mock('@google/generative-ai', () => {
    return {
        GoogleGenerativeAI: class GoogleGenerativeAI {
            constructor(apiKey) {
                this.apiKey = apiKey;
            }
            getGenerativeModel() {
                return {
                    embedContent: jest.fn(),
                    generateContent: jest.fn()
                };
            }
        }
    };
});

describe('AI Architecture Integration', () => {
    const originalEnv = process.env;

    beforeEach(() => {
        jest.resetModules();
        process.env = { ...originalEnv };
        // Ensure dummy keys are present for tests
        process.env.OPENAI_API_KEY = 'test-openai-key';
        process.env.GEMINI_API_KEY = 'test-gemini-key';

        // Reset singleton instance
        AIFactory.instance = null;
        AIFactory.currentProviderName = null;
    });

    afterAll(() => {
        process.env = originalEnv;
    });

    it('should initialize OpenAIProvider by default', () => {
        delete process.env.AI_PROVIDER;
        const provider = AIFactory.getProvider();
        expect(provider).toBeInstanceOf(OpenAIProvider);
    });

    it('should initialize OpenAIProvider when explicitly set', () => {
        process.env.AI_PROVIDER = 'openai';
        const provider = AIFactory.getProvider();
        expect(provider).toBeInstanceOf(OpenAIProvider);
    });

    it('should initialize GeminiProvider when set to gemini', () => {
        process.env.AI_PROVIDER = 'gemini';
        const provider = AIFactory.getProvider();
        expect(provider).toBeInstanceOf(GeminiProvider);
    });

    it('should return the same instance (Singleton)', () => {
        process.env.AI_PROVIDER = 'openai';
        const provider1 = AIFactory.getProvider();
        const provider2 = AIFactory.getProvider();
        expect(provider1).toBe(provider2);
    });

    it('should switch provider if env changes (and factory logic supports it)', () => {
        process.env.AI_PROVIDER = 'openai';
        const provider1 = AIFactory.getProvider();
        expect(provider1).toBeInstanceOf(OpenAIProvider);

        process.env.AI_PROVIDER = 'gemini';
        const provider2 = AIFactory.getProvider();
        expect(provider2).toBeInstanceOf(GeminiProvider);
        expect(provider1).not.toBe(provider2);
    });
});

