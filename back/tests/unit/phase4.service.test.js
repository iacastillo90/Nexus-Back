const prismService = require('../../src/services/prism.service');
const newsService = require('../../src/services/news.service');
const AIFactory = require('../../src/services/ai/ai.factory');
const vibesService = require('../../src/services/vibes.service');
const postService = require('../../src/services/post.service');
const { User, Post, UserInsight } = require('../../src/models');

// Mock dependencies
jest.mock('../../src/services/ai/ai.factory');
jest.mock('../../src/services/vibes.service');
jest.mock('../../src/services/post.service');
jest.mock('../../src/models', () => ({
    User: { findByPk: jest.fn(), findOne: jest.fn() },
    Post: { findAll: jest.fn() },
    UserInsight: { create: jest.fn(), findAll: jest.fn() },
    Sequelize: { Op: { gte: 'gte' } }
}));
jest.mock('../../src/utils/logger', () => ({
    info: jest.fn(),
    error: jest.fn(),
    warn: jest.fn()
}));

describe('Phase 4 Services', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('Prism Service', () => {
        it('should generate insight', async () => {
            // Mock Data
            User.findByPk.mockResolvedValue({ username: 'testuser' });
            vibesService.getUserVibes.mockResolvedValue({ vibeScore: 80 });
            Post.findAll.mockResolvedValue(Array(5).fill({ content: 'test', sentiment: 'positive' }));

            // Mock AI
            const mockProvider = {
                generateText: jest.fn().mockResolvedValue(JSON.stringify({
                    type: 'personality',
                    content: 'You are a visionary.',
                    confidence: 0.9
                }))
            };
            AIFactory.getProvider.mockReturnValue(mockProvider);

            UserInsight.create.mockResolvedValue({ id: 'insight-1' });

            const result = await prismService.generateInsight('user-1');

            expect(result).toBeDefined();
            expect(UserInsight.create).toHaveBeenCalledWith(expect.objectContaining({
                type: 'personality',
                content: 'You are a visionary.'
            }));
        });
    });

    describe('News Service', () => {
        it('should generate daily briefing', async () => {
            // Mock Bot User
            User.findOne.mockResolvedValue({ id: 'bot-id', username: 'NexusNews' });

            // Mock Trends (Posts)
            Post.findAll.mockResolvedValue(Array(10).fill({ content: 'Nexus is great', sentiment: 'positive' }));

            // Mock AI
            const mockProvider = {
                generateText: jest.fn().mockResolvedValue('BREAKING: Nexus is live! 🚀')
            };
            AIFactory.getProvider.mockReturnValue(mockProvider);

            // Mock Post Creation
            postService.createPost.mockResolvedValue({ id: 'news-post-1' });

            const result = await newsService.generateDailyBriefing();

            expect(result).toBeDefined();
            expect(postService.createPost).toHaveBeenCalledWith(
                'bot-id',
                'BREAKING: Nexus is live! 🚀',
                null, null, null, null,
                expect.any(Object)
            );
        });
    });
});

