const request = require('supertest');
const jwt = require('jsonwebtoken');
const app = require('../../src/app');
const { sequelize } = require('../../src/models');

// Mock Redis
jest.mock('../../src/config/redis', () => {
    const mRedisClient = {
        connect: jest.fn(),
        duplicate: jest.fn().mockReturnThis(),
        sAdd: jest.fn(),
        sRem: jest.fn(),
        sCard: jest.fn().mockResolvedValue(0),
        del: jest.fn(),
        json: { set: jest.fn() },
        ft: { search: jest.fn(), info: jest.fn(), create: jest.fn() },
        on: jest.fn(),
    };
    return {
        getRedisClient: jest.fn(() => Promise.resolve(mRedisClient)),
        initVectorIndex: jest.fn()
    };
});

jest.mock('../../src/services/embedding.service', () => ({
    generateEmbedding: jest.fn()
}));

// Mock OpenAI TTS
jest.mock('openai', () => {
    return jest.fn().mockImplementation(() => ({
        audio: {
            speech: {
                create: jest.fn().mockResolvedValue({
                    arrayBuffer: jest.fn().mockResolvedValue(Buffer.from('fake-audio-data'))
                })
            }
        },
        embeddings: {
            create: jest.fn().mockResolvedValue({
                data: [{ embedding: [0.1, 0.2, 0.3] }]
            })
        }
    }));
});

describe('Audio Integration', () => {
    let token;
    let userId;
    let postId;

    beforeAll(async () => {
        await sequelize.sync({ alter: true });
        const { User, Role, Post, Comment, Like, Follow } = require('../../src/models');

        // Clean up
        await Like.destroy({ where: {}, truncate: false, force: true });
        await Comment.destroy({ where: {}, truncate: false, force: true });
        await Post.destroy({ where: {}, truncate: false, force: true });
        await Follow.destroy({ where: {}, truncate: false, force: true });
        await User.destroy({ where: {}, truncate: false, force: true });
        await Role.destroy({ where: {}, truncate: false, force: true });

        const [role] = await Role.findOrCreate({
            where: { name: 'user' },
            defaults: { description: 'Standard user' }
        });

        const [user] = await User.findOrCreate({
            where: { username: 'audiouser' },
            defaults: {
                email: 'audio@example.com',
                passwordHash: 'hashedpassword',
                roleId: role.id
            }
        });
        userId = user.id;

        token = jwt.sign({ id: userId, username: 'audiouser' }, process.env.JWT_SECRET || 'default_secret_do_not_use_in_prod');

        // Create a test post
        const post = await Post.create({
            userId,
            content: 'This is a test post for audio generation.'
        });
        postId = post.id;
    }, 30000);

    afterAll(async () => {
        await sequelize.close();
    });

    it('should get available voices', async () => {
        const res = await request(app)
            .get('/api/v1/audio/voices')
            .expect(200);

        expect(res.body.voices).toBeInstanceOf(Array);
        expect(res.body.voices.length).toBeGreaterThan(0);
        expect(res.body.default).toBe('alloy');
    });

    it('should generate and stream audio for a post', async () => {
        const res = await request(app)
            .get(`/api/v1/audio/post/${postId}`)
            .expect(200);

        expect(res.headers['content-type']).toBe('audio/mpeg');
        expect(res.headers['cache-control']).toContain('public');
    }, 15000);

    it('should reject invalid voice', async () => {
        const res = await request(app)
            .get(`/api/v1/audio/post/${postId}?voice=invalid`)
            .expect(400);

        expect(res.body.error).toBe('Invalid voice');
    });
});

