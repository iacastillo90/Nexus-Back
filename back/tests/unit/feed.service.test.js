const FeedService = require('../../src/services/feed.service');
const vibesService = require('../../src/services/vibes.service');
const { Post, User, Comment, Like } = require('../../src/models');
const logger = require('../../src/utils/logger');

// Mock Dependencies
jest.mock('../../src/services/vibes.service');
jest.mock('../../src/models');
jest.mock('../../src/utils/logger');

describe('FeedService', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('getNeuroFeed', () => {
        it('should generate feed sorted by neuro score', async () => {
            // Mock User Vibes
            vibesService.getUserVibes.mockResolvedValue({
                sentimentDistribution: { positive: 10, neutral: 5, negative: 2 }
            });

            // Mock Candidates
            const mockPosts = [
                {
                    id: 1,
                    sentiment: 'positive',
                    createdAt: new Date(),
                    likes: [{ id: 1 }, { id: 2 }], // 2 likes
                    comments: [],
                    toJSON: () => ({ id: 1, sentiment: 'positive' })
                },
                {
                    id: 2,
                    sentiment: 'negative',
                    createdAt: new Date(Date.now() - 1000 * 60 * 60 * 12), // 12h ago
                    likes: [],
                    comments: [],
                    toJSON: () => ({ id: 2, sentiment: 'negative' })
                }
            ];

            Post.findAll.mockResolvedValue(mockPosts);

            const feed = await FeedService.getNeuroFeed('user1');

            expect(feed).toHaveLength(2);
            expect(feed[0].id).toBe(1); // Positive post should be first (match + recency + engagement)
            expect(feed[0]).toHaveProperty('neuroScore');
        });

        it('should handle empathy logic (negative user -> positive post)', async () => {
            // Mock Negative User Vibes
            vibesService.getUserVibes.mockResolvedValue({
                sentimentDistribution: { positive: 2, neutral: 5, negative: 10 }
            });

            const mockPosts = [
                {
                    id: 1,
                    sentiment: 'positive',
                    createdAt: new Date(),
                    likes: [],
                    comments: [],
                    toJSON: () => ({ id: 1, sentiment: 'positive' })
                }
            ];

            Post.findAll.mockResolvedValue(mockPosts);

            const feed = await FeedService.getNeuroFeed('user1');

            // Score calculation check:
            // VibeMatch: 80 (Empathy) * 0.4 = 32
            // Engagement: 0
            // Recency: ~100 * 0.3 = 30
            // Total ~ 62
            expect(feed[0].neuroScore).toBeGreaterThan(60);
        });

        it('should handle errors gracefully', async () => {
            vibesService.getUserVibes.mockRejectedValue(new Error('DB Error'));

            await expect(FeedService.getNeuroFeed('user1'))
                .rejects.toThrow('DB Error');

            expect(logger.error).toHaveBeenCalled();
        });
    });
});

