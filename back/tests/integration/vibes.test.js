const request = require('supertest');
const app = require('../../src/app');
const { User, Post } = require('../../src/models');
const jwt = require('jsonwebtoken');
const AIFactory = require('../../src/services/ai/ai.factory');
const vibesService = require('../../src/services/vibes.service');

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

describe('Vibes Dashboard Integration', () => {
    let authToken;
    let user;
    let mockProvider;

    beforeAll(async () => {
        // Create test user
        const uniqueId = Date.now();
        user = await User.create({
            username: `vibesuser_${uniqueId}`,
            email: `vibes_${uniqueId}@example.com`,
            passwordHash: 'hashedpassword',
            isActive: true,
            isVerified: true,
            echoEnabled: true,
            echoPlan: 'premium'
        });

        authToken = generateToken(user);

        // Setup mock provider
        mockProvider = {
            generateText: jest.fn().mockResolvedValue(JSON.stringify({
                sentiment: 'positive',
                emotionalTone: { joy: 0.9, excitement: 0.8 }
            }))
        };

        AIFactory.getProvider.mockReturnValue(mockProvider);

        // Create some posts with sentiment
        await Post.create({
            userId: user.id,
            content: 'I am so happy today!',
            sentiment: 'positive',
            emotionalTone: { joy: 0.9 }
        });

        await Post.create({
            userId: user.id,
            content: 'This is okay I guess.',
            sentiment: 'neutral',
            emotionalTone: { boredom: 0.5 }
        });
    });

    afterAll(async () => {
        if (user) {
            await Post.destroy({ where: { userId: user.id } });
            await User.destroy({ where: { id: user.id } });
        }
    });

    describe('GET /api/v1/vibes/dashboard', () => {
        it('should return user vibe stats', async () => {
            const res = await request(app)
                .get('/api/v1/vibes/dashboard')
                .set('Authorization', `Bearer ${authToken}`);

            expect(res.status).toBe(200);
            expect(res.body.success).toBe(true);
            expect(res.body.data).toHaveProperty('vibeScore');
            expect(res.body.data).toHaveProperty('sentimentDistribution');
            expect(res.body.data.sentimentDistribution.positive).toBeGreaterThan(0);
        });
    });

    describe('GET /api/v1/vibes/community', () => {
        it('should return community trends', async () => {
            const res = await request(app)
                .get('/api/v1/vibes/community')
                .set('Authorization', `Bearer ${authToken}`);

            expect(res.status).toBe(200);
            expect(res.body.success).toBe(true);
            expect(res.body.data).toHaveProperty('positive');
            expect(res.body.data).toHaveProperty('neutral');
            expect(res.body.data).toHaveProperty('negative');
        });
    });
});

