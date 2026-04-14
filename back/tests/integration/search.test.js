const request = require('supertest');
const jwt = require('jsonwebtoken');
const app = require('../../src/app');
const { sequelize } = require('../../src/models');

// Mock Redis & OpenAI
jest.mock('../../src/config/redis', () => {
    const mRedisClient = {
        connect: jest.fn(),
        json: { set: jest.fn() },
        ft: {
            search: jest.fn(),
            info: jest.fn(),
            create: jest.fn()
        },
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

const { getRedisClient } = require('../../src/config/redis');
const embeddingService = require('../../src/services/embedding.service');

describe('Search Integration', () => {
    let token;
    let userId;
    let mockRedis;

    beforeAll(async () => {
        await sequelize.sync({ alter: true });
        const { User, Role, Post, Comment, Like, Follow } = require('../../src/models');

        // Clean up data (hard delete to avoid unique constraint issues with soft-deleted rows)
        // Order matters due to FK constraints
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
            where: { username: 'searchuser' },
            defaults: {
                email: 'search@example.com',
                passwordHash: 'hashedpassword',
                roleId: role.id
            }
        });
        userId = user.id;

        token = jwt.sign({ id: userId, username: 'searchuser' }, process.env.JWT_SECRET || 'default_secret_do_not_use_in_prod');
        mockRedis = await getRedisClient();
    }, 30000);

    afterAll(async () => {
        await sequelize.close();
    });

    beforeEach(() => {
        jest.clearAllMocks();
    });

    it('should index post on creation', async () => {
        // Mock embedding generation
        embeddingService.generateEmbedding.mockResolvedValue([0.1, 0.2, 0.3]);

        // Mock Redis JSON.SET
        mockRedis.json.set.mockResolvedValue('OK');

        const res = await request(app)
            .post('/api/v1/posts')
            .set('Authorization', `Bearer ${token}`)
            .send({ content: 'Semantic search test post' })
            .expect(201);

        // Verify embedding was generated
        expect(embeddingService.generateEmbedding).toHaveBeenCalledWith('Semantic search test post');

        // Wait for async operation
        await new Promise(resolve => setTimeout(resolve, 100));

        expect(mockRedis.json.set).toHaveBeenCalled();
    });

    it('should return search results', async () => {
        // Mock embedding
        embeddingService.generateEmbedding.mockResolvedValue([0.1, 0.2, 0.3]);

        // Mock Redis FT.SEARCH response
        // We need a real post ID to be returned
        const { Post } = require('../../src/models');
        const post = await Post.create({
            userId,
            content: 'Result post'
        });

        mockRedis.ft.search.mockResolvedValue({
            total: 1,
            documents: [
                { id: `post:${post.id}`, value: { score: 0.1 } }
            ]
        });

        const res = await request(app)
            .get('/api/v1/search?q=test')
            .set('Authorization', `Bearer ${token}`)
            .expect(200);

        expect(res.body.data).toHaveLength(1);
        expect(res.body.data[0].id).toBe(post.id);
        expect(mockRedis.ft.search).toHaveBeenCalled();
    });
});

