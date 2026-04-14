const request = require('supertest');
const app = require('../../src/app');
const { User, Post } = require('../../src/models');
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

describe('Neuro-Feed Integration', () => {
    let authToken;
    let user;
    let mockProvider;

    beforeAll(async () => {
        // Create test user
        const uniqueId = Date.now();
        user = await User.create({
            username: `neuro_${uniqueId}`,
            email: `neuro_${uniqueId}@example.com`,
            passwordHash: 'hashedpassword',
            isActive: true,
            isVerified: true
        });

        authToken = generateToken(user);

        // Setup mock provider
        mockProvider = {
            generateText: jest.fn().mockResolvedValue(JSON.stringify({
                sentiment: 'positive',
                emotionalTone: { joy: 0.9 }
            }))
        };
        AIFactory.getProvider.mockReturnValue(mockProvider);

        // Create posts with different sentiments
        // Post 1: Positive (Should match user vibe if user is positive)
        await Post.create({
            userId: user.id,
            content: 'Positive vibes only!',
            sentiment: 'positive',
            visibility: 'PUBLIC'
        });

        // Post 2: Negative
        await Post.create({
            userId: user.id,
            content: 'Feeling sad today.',
            sentiment: 'negative',
            visibility: 'PUBLIC'
        });
    });

    afterAll(async () => {
        if (user) {
            await Post.destroy({ where: { userId: user.id } });
            await User.destroy({ where: { id: user.id } });
        }
    });

    describe('GET /api/v1/feed/neuro', () => {
        it('should return posts with neuroScore', async () => {
            const res = await request(app)
                .get('/api/v1/feed/neuro')
                .set('Authorization', `Bearer ${authToken}`);

            expect(res.status).toBe(200);
            expect(res.body.success).toBe(true);
            expect(Array.isArray(res.body.data)).toBe(true);
            expect(res.body.data.length).toBeGreaterThan(0);

            // Check if neuroScore is present
            expect(res.body.data[0]).toHaveProperty('neuroScore');

            // Verify sorting (descending score)
            const scores = res.body.data.map(p => p.neuroScore);
            const sortedScores = [...scores].sort((a, b) => b - a);
            expect(scores).toEqual(sortedScores);
        });
    });
});

