const request = require('supertest');
const jwt = require('jsonwebtoken');
const app = require('../../src/app');
const { sequelize } = require('../../src/models');

const logger = require('../../src/utils/logger');

// Mock Redis
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
        del: jest.fn(),
        get: jest.fn(),
        set: jest.fn(),
    };
    return {
        getRedisClient: jest.fn(() => Promise.resolve(mRedisClient)),
        initVectorIndex: jest.fn()
    };
});

describe('User Integration', () => {
    let token;
    let userId;

    beforeAll(async () => {
        // Force sync to ensure clean state
        try {
            await sequelize.sync({ force: true });
        } catch (error) {
            logger.error('[UserTest] Error syncing database:', { error: error.message });
        }
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
            where: { username: 'testuser' },
            defaults: {
                email: 'test@example.com',
                passwordHash: 'hashedpassword',
                roleId: role.id,
                firstName: 'Original Name'
            }
        });
        userId = user.id;

        token = jwt.sign({ id: userId, username: 'testuser' }, process.env.JWT_SECRET || 'default_secret_do_not_use_in_prod');
    }, 30000);

    afterAll(async () => {
        await sequelize.close();
    });

    it('should get user profile', async () => {
        const res = await request(app)
            .get(`/api/v1/users/${userId}`)
            .set('Authorization', `Bearer ${token}`)
            .expect(200);

        expect(res.body.id).toBe(userId);
        expect(res.body.username).toBe('testuser');
        expect(res.body.firstName).toBe('Original Name');
    });

    it('should update user profile', async () => {
        const res = await request(app)
            .put(`/api/v1/users/${userId}`)
            .set('Authorization', `Bearer ${token}`)
            .send({
                firstName: 'Updated Name'
            })
            .expect(200);

        expect(res.body.firstName).toBe('Updated Name');

        // Verify persistence
        const getRes = await request(app)
            .get(`/api/v1/users/${userId}`)
            .set('Authorization', `Bearer ${token}`)
            .expect(200);

        expect(getRes.body.firstName).toBe('Updated Name');
    });

    it('should fail to update another users profile', async () => {
        const otherId = '00000000-0000-0000-0000-000000000000'; // Fake UUID

        await request(app)
            .put(`/api/v1/users/${otherId}`)
            .set('Authorization', `Bearer ${token}`)
            .send({ firstName: 'Hacked' })
            .expect(403);
    });
});

