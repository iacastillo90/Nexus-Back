const request = require('supertest');
const { User, Dream, DreamContribution } = require('../../src/models');
const jwt = require('jsonwebtoken');

// Mock AIFactory
jest.mock('../../src/services/ai/ai.factory', () => ({
    getProvider: jest.fn().mockReturnValue({
        generateText: jest.fn().mockResolvedValue('AI generated dream narrative segment...'),
        generateEmbedding: jest.fn().mockResolvedValue([])
    })
}));

// Mock Socket.IO
jest.mock('../../src/config/socket', () => ({
    getIO: jest.fn().mockReturnValue({
        to: jest.fn().mockReturnThis(),
        emit: jest.fn()
    })
}));

const app = require('../../src/app');

const generateToken = (user) => {
    return jwt.sign(
        { id: user.id, username: user.username, role: user.role },
        process.env.JWT_SECRET || 'default_secret_do_not_use_in_prod',
        { expiresIn: '1h' }
    );
};

describe('Collective Dreaming Integration', () => {
    let authToken;
    let user;
    let dreamId;

    beforeAll(async () => {
        // Create test user
        const uniqueId = Date.now();
        user = await User.create({
            username: `dreamer_${uniqueId}`,
            email: `dreamer_${uniqueId}@example.com`,
            passwordHash: 'hashedpassword',
            isActive: true,
            isVerified: true
        });

        authToken = generateToken(user);
    });

    afterAll(async () => {
        if (user) {
            await Dream.destroy({ where: { createdBy: user.id } });
            await User.destroy({ where: { id: user.id } });
        }
    });

    describe('Dream Flow', () => {
        it('should create a new dream', async () => {
            const res = await request(app)
                .post('/api/v1/dreams')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    title: 'Test Dream',
                    theme: 'Surrealist Landscape'
                });

            expect(res.status).toBe(201);
            expect(res.body.id).toBeDefined();
            expect(res.body.title).toBe('Test Dream');
            expect(res.body.currentState).toBeDefined();

            dreamId = res.body.id;
        });

        it('should add a contribution and evolve dream', async () => {
            const res = await request(app)
                .post(`/api/v1/dreams/${dreamId}/contribute`)
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    content: 'A flying fish appears.'
                });

            expect(res.status).toBe(201);
            expect(res.body.content).toBe('A flying fish appears.');

            // Verify dream state updated (AI evolution)
            const updatedDream = await request(app)
                .get(`/api/v1/dreams/${dreamId}`)
                .set('Authorization', `Bearer ${authToken}`);

            expect(updatedDream.body.currentState.text).toBe('AI generated dream narrative segment...');
        });
    });
});

