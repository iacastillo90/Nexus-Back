const karmaService = require('../../src/services/karma.service');
const { User, Follow, Post } = require('../../src/models');
const { getRedisClient } = require('../../src/config/redis');

// Mock dependencies
jest.mock('../../src/models', () => ({
    User: { findByPk: jest.fn() },
    Follow: { findAll: jest.fn() },
    Post: { findAll: jest.fn() },
    Like: { count: jest.fn() },
    Comment: { count: jest.fn() },
    sequelize: {
        fn: jest.fn(),
        col: jest.fn(),
        query: jest.fn(),
        model: jest.fn().mockReturnValue({ count: jest.fn() }),
        QueryTypes: { SELECT: 'SELECT' }
    }
}));

jest.mock('../../src/config/redis', () => ({
    getRedisClient: jest.fn().mockResolvedValue({
        get: jest.fn(),
        setEx: jest.fn()
    })
}));

jest.mock('../../src/utils/logger', () => ({
    info: jest.fn(),
    warn: jest.fn(),
    error: jest.fn(),
    debug: jest.fn()
}));

describe('Karma Service', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('calculateKarmaScore', () => {
        it('should calculate score for new user', async () => {
            // Mock User (New)
            User.findByPk.mockResolvedValue({
                id: 'user-new',
                createdAt: new Date() // Just created
            });

            // Mock Posts (None)
            Post.findAll.mockResolvedValue([]);

            // Mock Followers (None)
            Follow.findAll.mockResolvedValue([]);

            const result = await karmaService.calculateKarmaScore('user-new');

            expect(result.score).toBeLessThan(200); // Should be low
            expect(result.tier).toBe('SUSPICIOUS'); // or NEWCOMER depending on logic
        });

        it('should calculate score for established user', async () => {
            // Mock User (Old)
            User.findByPk.mockResolvedValue({
                id: 'user-old',
                createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24 * 365) // 1 year old
            });

            // Mock Posts (Active)
            Post.findAll.mockResolvedValue([{ totalPosts: 100 }]); // Mocking the raw response structure used in service

            // Mock Engagement
            // Since we mocked sequelize.model().count()
            require('../../src/models').sequelize.model().count.mockResolvedValue(500); // 500 likes/comments

            // Mock Followers
            Follow.findAll.mockResolvedValue(Array(50).fill({ followerId: 'follower-id' }));

            // Mock Redis for follower karma
            const redis = await getRedisClient();
            redis.get.mockResolvedValue(JSON.stringify({ score: 500 }));

            const result = await karmaService.calculateKarmaScore('user-old');

            expect(result.score).toBeGreaterThan(400);
            expect(result.tier).not.toBe('SUSPICIOUS');
        });
    });
});

