const request = require('supertest');
const jwt = require('jsonwebtoken');
const app = require('../../src/app');
const { sequelize } = require('../../src/models');

// Mock Redis
jest.mock('../../src/config/redis', () => {
    const mRedisClient = {
        connect: jest.fn(),
        get: jest.fn(),
        setEx: jest.fn(),
        del: jest.fn(),
        keys: jest.fn(),
        on: jest.fn(),
    };
    return {
        getRedisClient: jest.fn(() => Promise.resolve(mRedisClient)),
    };
});

const { getRedisClient } = require('../../src/config/redis');

describe('Cache Integration', () => {
    let token;
    let userId;
    let mockRedis;

    beforeAll(async () => {
        // Sync DB (alter: true to avoid FK issues with force)
        await sequelize.sync({ alter: true });

        const { User, Role, Post, Comment, Like } = require('../../src/models');

        // Clean up data (hard delete to avoid unique constraint issues with soft-deleted rows)
        // Order matters due to FK constraints
        await Like.destroy({ where: {}, truncate: false, force: true });
        await Comment.destroy({ where: {}, truncate: false, force: true });
        await Post.destroy({ where: {}, truncate: false, force: true });
        await User.destroy({ where: {}, truncate: false, force: true });
        await Role.destroy({ where: {}, truncate: false, force: true });

        const [role] = await Role.findOrCreate({
            where: { name: 'user' },
            defaults: {
                description: 'Standard user'
            }
        });

        const [user] = await User.findOrCreate({
            where: { username: 'testuser' },
            defaults: {
                email: 'test@example.com',
                passwordHash: 'hashedpassword',
                roleId: role.id
            }
        });
        userId = user.id;

        token = jwt.sign({ id: userId, username: 'testuser' }, process.env.JWT_SECRET || 'default_secret_do_not_use_in_prod');

        mockRedis = await getRedisClient();
    }, 30000); // Increase timeout to 30s

    afterAll(async () => {
        await sequelize.close();
    });

    beforeEach(() => {
        jest.clearAllMocks();
    });

    it('should cache GET /api/v1/feed response', async () => {
        // Mock Redis GET to return null (Cache Miss)
        mockRedis.get.mockResolvedValueOnce(null);
        // Mock Redis SET
        mockRedis.setEx.mockResolvedValue(true);

        // 1. First request (Cache Miss)
        const res1 = await request(app)
            .get('/api/v1/feed')
            .set('Authorization', `Bearer ${token}`)
            .expect(200);

        expect(res1.body.data).toBeInstanceOf(Array);
        expect(mockRedis.get).toHaveBeenCalledWith(expect.stringContaining(`feed:${userId}`));
        expect(mockRedis.setEx).toHaveBeenCalled(); // Should cache the result

        // Mock Redis GET to return cached data (Cache Hit)
        const cachedData = { data: [], meta: { page: 1, limit: 20 } };
        mockRedis.get.mockResolvedValueOnce(JSON.stringify(cachedData));

        // 2. Second request (Cache Hit)
        const res2 = await request(app)
            .get('/api/v1/feed')
            .set('Authorization', `Bearer ${token}`)
            .expect(200);

        expect(res2.body).toEqual(cachedData);
    });

    it('should invalidate cache when creating a post', async () => {
        // Mock Redis DEL
        mockRedis.del.mockResolvedValue(1);

        // Create Post
        await request(app)
            .post('/api/v1/posts')
            .set('Authorization', `Bearer ${token}`)
            .send({ content: 'New Post' })
            .expect(201);

        // Check cache invalidation calls
        expect(mockRedis.del).toHaveBeenCalled();
        // Specifically check for feed invalidation
        expect(mockRedis.del).toHaveBeenCalledWith(`feed:${userId}:page:1`);
    });
});

