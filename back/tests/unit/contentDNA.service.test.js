const contentDNAService = require('../../src/services/contentDNA.service');
const { ContentSignature } = require('../../src/models');
const dnaUtils = require('../../src/utils/crypto/dna.utils');

// Mock dependencies
jest.mock('../../src/models', () => ({
    ContentSignature: {
        create: jest.fn(),
        findOne: jest.fn()
    }
}));
jest.mock('../../src/config/redis', () => ({
    getRedisClient: jest.fn().mockResolvedValue({
        setEx: jest.fn(),
        get: jest.fn(),
        set: jest.fn(), // Added set
        sAdd: jest.fn(),
        sMembers: jest.fn()
    })
}));
jest.mock('../../src/utils/logger', () => ({
    info: jest.fn(),
    error: jest.fn(),
    debug: jest.fn(),
    warn: jest.fn()
}));
jest.mock('../../src/utils/crypto/dna.utils', () => ({
    calculateDNAHash: jest.fn(),
    buildPayload: jest.fn(),
    generateMediaHash: jest.fn()
}));

describe('Content DNA Service', () => {
    beforeEach(() => {
        jest.clearAllMocks();
        process.env.CONTENT_DNA_SECRET = 'test-secret';
    });

    describe('generateContentDNA', () => {
        it('should generate unique DNA', async () => {
            const content = {
                authorId: 'user-1',
                contentText: 'Hello World',
                contentType: 'post'
            };

            dnaUtils.buildPayload.mockReturnValue('payload-1');
            dnaUtils.calculateDNAHash.mockReturnValue('hash-1');
            ContentSignature.create.mockResolvedValue({});

            const result = await contentDNAService.generateContentDNA(content);

            expect(result.dnaHash).toBe('hash-1');
            expect(dnaUtils.buildPayload).toHaveBeenCalled();
            expect(dnaUtils.calculateDNAHash).toHaveBeenCalledWith('payload-1');
        });

        it('should throw Error for missing content', async () => {
            await expect(
                contentDNAService.generateContentDNA({})
            ).rejects.toThrow('Invalid content for DNA generation');
        });
    });

    describe('verifyContentDNA', () => {
        const validHash = 'valid-hash';

        it('should verify valid DNA hash from cache', async () => {
            const redis = require('../../src/config/redis').getRedisClient();
            (await redis).get.mockResolvedValue(JSON.stringify({
                authorId: 'user-test',
                timestamp: 123456789,
                isValid: true
            }));

            const result = await contentDNAService.verifyContentDNA(validHash);

            expect(result.isValid).toBe(true);
            expect(result.source).toBe('cache');
        });

        it('should verify valid DNA hash from DB', async () => {
            const redis = require('../../src/config/redis').getRedisClient();
            (await redis).get.mockResolvedValue(null);

            ContentSignature.findOne.mockResolvedValue({
                authorId: 'user-test',
                timestamp: 123456789,
                dnaHash: validHash
            });

            const result = await contentDNAService.verifyContentDNA(validHash);

            expect(result.isValid).toBe(true);
            expect(result.source).toBe('database');
        });

        it('should return invalid for unknown hash', async () => {
            const redis = require('../../src/config/redis').getRedisClient();
            (await redis).get.mockResolvedValue(null);
            ContentSignature.findOne.mockResolvedValue(null);

            const result = await contentDNAService.verifyContentDNA('unknown-hash');

            expect(result.isValid).toBe(false);
            expect(result.reason).toBe('DNA not found');
        });
    });
});

