const request = require('supertest');
const jwt = require('jsonwebtoken');
const app = require('../../src/app');
const { sequelize } = require('../../src/models');

// Mock Redis
jest.mock('../../src/config/redis', () => {
    const mRedisClient = {
        connect: jest.fn(),
        duplicate: jest.fn().mockReturnThis(),
        get: jest.fn().mockResolvedValue(null),
        setEx: jest.fn(),
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

describe('Graph Integration', () => {
    let token;
    let user1Id, user2Id, user3Id;

    beforeAll(async () => {
        await sequelize.sync({ alter: true });
        const { User, Role, Post, Comment, Like, Follow } = require('../../src/models');

        // Clean up
        await Follow.destroy({ where: {}, truncate: false, force: true });
        await Like.destroy({ where: {}, truncate: false, force: true });
        await Comment.destroy({ where: {}, truncate: false, force: true });
        await Post.destroy({ where: {}, truncate: false, force: true });
        await User.destroy({ where: {}, truncate: false, force: true });
        await Role.destroy({ where: {}, truncate: false, force: true });

        const [role] = await Role.findOrCreate({
            where: { name: 'user' },
            defaults: { description: 'Standard user' }
        });

        // Create test users
        const [user1] = await User.findOrCreate({
            where: { username: 'graphuser1' },
            defaults: {
                email: 'graph1@example.com',
                passwordHash: 'hashedpassword',
                roleId: role.id
            }
        });
        user1Id = user1.id;

        const [user2] = await User.findOrCreate({
            where: { username: 'graphuser2' },
            defaults: {
                email: 'graph2@example.com',
                passwordHash: 'hashedpassword',
                roleId: role.id
            }
        });
        user2Id = user2.id;

        const [user3] = await User.findOrCreate({
            where: { username: 'graphuser3' },
            defaults: {
                email: 'graph3@example.com',
                passwordHash: 'hashedpassword',
                roleId: role.id
            }
        });
        user3Id = user3.id;

        // Create follow relationships
        await Follow.create({ followerId: user1Id, followingId: user2Id });
        await Follow.create({ followerId: user2Id, followingId: user3Id });
        await Follow.create({ followerId: user3Id, followingId: user1Id });

        token = jwt.sign({ id: user1Id, username: 'graphuser1' }, process.env.JWT_SECRET || 'default_secret_do_not_use_in_prod');
    }, 30000);

    afterAll(async () => {
        await sequelize.close();
    });

    it('should get network graph', async () => {
        const res = await request(app)
            .get('/api/v1/graph/network')
            .expect(200);

        expect(res.body.nodes).toBeInstanceOf(Array);
        expect(res.body.edges).toBeInstanceOf(Array);
        expect(res.body.metadata).toBeDefined();
        expect(res.body.metadata.totalNodes).toBeGreaterThan(0);
    });

    it('should get user neighborhood', async () => {
        const res = await request(app)
            .get(`/api/v1/graph/user/${user1Id}/neighborhood?depth=2`)
            .expect(200);

        expect(res.body.nodes).toBeInstanceOf(Array);
        expect(res.body.edges).toBeInstanceOf(Array);
        expect(res.body.metadata.centerNode).toBe(user1Id);
    });

    it('should get influential users', async () => {
        const res = await request(app)
            .get('/api/v1/graph/influencers?limit=5')
            .expect(200);

        expect(res.body.data).toBeInstanceOf(Array);
        expect(res.body.meta.total).toBeGreaterThan(0);

        // Verify structure
        if (res.body.data.length > 0) {
            expect(res.body.data[0]).toHaveProperty('userId');
            expect(res.body.data[0]).toHaveProperty('influenceScore');
            expect(res.body.data[0]).toHaveProperty('username');
        }
    });
});

