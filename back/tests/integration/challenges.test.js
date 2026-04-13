const request = require('supertest');
const app = require('../../src/app');
const { User, Challenge, ChallengeParticipant, Post } = require('../../src/models');
const jwt = require('jsonwebtoken');
const AIFactory = require('../../src/services/ai/ai.factory');

// Mock AIFactory
jest.mock('../../src/services/ai/ai.factory');

// Mock QuotaService
jest.mock('../../src/services/quota.service', () => ({
    checkQuota: jest.fn().mockResolvedValue(true),
    getUsage: jest.fn().mockResolvedValue(0)
}));

const generateToken = (user) => {
    return jwt.sign(
        { id: user.id, username: user.username, role: user.role },
        process.env.JWT_SECRET || 'default_secret_do_not_use_in_prod',
        { expiresIn: '1h' }
    );
};

describe('Social Challenges Integration', () => {
    let authToken;
    let user;
    let challenge;
    let mockProvider;

    beforeAll(async () => {
        // Create test user
        const uniqueId = Date.now();
        user = await User.create({
            username: `challenger_${uniqueId}`,
            email: `challenger_${uniqueId}@example.com`,
            passwordHash: 'hashedpassword',
            isActive: true,
            isVerified: true
        });

        authToken = generateToken(user);

        // Create a challenge
        challenge = await Challenge.create({
            title: 'Positivity Week',
            description: 'Post 2 positive vibes',
            type: 'weekly',
            requirements: { type: 'post_sentiment', value: 'positive', count: 2 },
            reward: { points: 50 },
            startDate: new Date(),
            endDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // +7 days
            isActive: true
        });

        // Setup mock provider for sentiment analysis
        mockProvider = {
            generateText: jest.fn().mockResolvedValue(JSON.stringify({
                sentiment: 'positive',
                emotionalTone: { joy: 0.9 }
            }))
        };
        AIFactory.getProvider.mockReturnValue(mockProvider);
    });

    afterAll(async () => {
        if (user) {
            await ChallengeParticipant.destroy({ where: { userId: user.id } });
            await Post.destroy({ where: { userId: user.id } });
            await User.destroy({ where: { id: user.id } });
        }
        if (challenge) {
            await Challenge.destroy({ where: { id: challenge.id } });
        }
    });

    describe('Challenge Flow', () => {
        it('should allow user to join a challenge', async () => {
            const res = await request(app)
                .post(`/api/v1/challenges/${challenge.id}/join`)
                .set('Authorization', `Bearer ${authToken}`);

            expect(res.status).toBe(200);
            expect(res.body.success).toBe(true);
            expect(res.body.data.status).toBe('active');
        });

        it('should update progress when posting positive content', async () => {
            // 1. Create a post (triggers Vibes -> Challenge)
            // We need to wait a bit because it's async fire-and-forget
            const vibesService = require('../../src/services/vibes.service');

            // Manually trigger analysis to ensure it runs in test env
            // In real app, PostService triggers it, but here we want to await it
            const post = await Post.create({
                userId: user.id,
                content: 'I love this challenge!',
                visibility: 'PUBLIC'
            });

            await vibesService.analyzePostSentiment(post.id);

            // Check progress
            const participant = await ChallengeParticipant.findOne({
                where: { userId: user.id, challengeId: challenge.id }
            });

            expect(participant.progress).toBe(1);
        });

        it('should complete challenge when requirements met', async () => {
            // 2. Create second post
            const vibesService = require('../../src/services/vibes.service');

            const post = await Post.create({
                userId: user.id,
                content: 'Another happy day!',
                visibility: 'PUBLIC'
            });

            await vibesService.analyzePostSentiment(post.id);

            // Check completion
            const participant = await ChallengeParticipant.findOne({
                where: { userId: user.id, challengeId: challenge.id }
            });

            expect(participant.progress).toBe(2);
            expect(participant.status).toBe('completed');
            expect(participant.completedAt).not.toBeNull();
        });
    });
});

