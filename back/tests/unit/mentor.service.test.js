const mentorService = require('../../src/services/mentor.service');
const AIFactory = require('../../src/services/ai/ai.factory');
const vibesService = require('../../src/services/vibes.service');
const karmaService = require('../../src/services/karma.service');
const { User, Post } = require('../../src/models');

// Mock dependencies
jest.mock('../../src/services/ai/ai.factory');
jest.mock('../../src/services/vibes.service');
jest.mock('../../src/services/karma.service');
jest.mock('../../src/models', () => ({
    User: { findByPk: jest.fn() },
    Post: { findAll: jest.fn() }
}));
jest.mock('../../src/utils/logger', () => ({
    info: jest.fn(),
    error: jest.fn(),
    debug: jest.fn()
}));

describe('Mentor Service', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('interact', () => {
        it('should generate response for Dr. Luma', async () => {
            // Mock Context Data
            User.findByPk.mockResolvedValue({ username: 'testuser', firstName: 'Test' });
            vibesService.getUserVibes.mockResolvedValue({ vibeScore: 80, topEmotions: { joy: 0.8 } });
            karmaService.calculateKarmaScore.mockResolvedValue({ score: 500, tier: 'ESTABLISHED' });
            Post.findAll.mockResolvedValue([{ content: 'Happy day', sentiment: 'positive' }]);

            // Mock AI Provider
            const mockProvider = {
                generateText: jest.fn().mockResolvedValue('Hello Test, I sense your joy!')
            };
            AIFactory.getProvider.mockReturnValue(mockProvider);

            const response = await mentorService.interact('user-1', 'LUMA', 'Hi Luma');

            expect(response).toBe('Hello Test, I sense your joy!');
            expect(mockProvider.generateText).toHaveBeenCalledWith(
                expect.stringContaining('Dr. Luma'),
                expect.stringContaining('joy')
            );
        });

        it('should throw error for unknown agent', async () => {
            await expect(
                mentorService.interact('user-1', 'UNKNOWN', 'Hi')
            ).rejects.toThrow('Agent UNKNOWN not found');
        });
    });
});

