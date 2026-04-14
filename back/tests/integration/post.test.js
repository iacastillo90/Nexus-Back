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
        del: jest.fn(),
        get: jest.fn(),
        set: jest.fn(),
    };
    return {
        getRedisClient: jest.fn(() => Promise.resolve(mRedisClient)),
        initVectorIndex: jest.fn()
    };
});

jest.mock('../../src/services/embedding.service', () => ({
    generateEmbedding: jest.fn().mockResolvedValue([0.1, 0.2, 0.3])
}));

describe('Post Integration', () => {
    let token;
    let userId;

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
            where: { username: 'postuser' },
            defaults: {
                email: 'post@example.com',
                passwordHash: 'hashedpassword',
                roleId: role.id
            }
        });
        userId = user.id;

        token = jwt.sign({ id: userId, username: 'postuser' }, process.env.JWT_SECRET || 'default_secret_do_not_use_in_prod');
    }, 30000);

    afterAll(async () => {
        await sequelize.close();
    });

    it('should create a new post', async () => {
        const res = await request(app)
            .post('/api/v1/posts')
            .set('Authorization', `Bearer ${token}`)
            .send({
                content: 'Hello World'
            })
            .expect(201);

        expect(res.body).toHaveProperty('id');
        expect(res.body.content).toBe('Hello World');
        expect(res.body.userId).toBe(userId);
    });

    it('should fail to create post without content', async () => {
        const res = await request(app)
            .post('/api/v1/posts')
            .set('Authorization', `Bearer ${token}`)
            .send({})
            .expect(400);

        // The validation error might come from Joi/Zod or the service
        expect(res.body).toHaveProperty('error');
    });

    it('should get a post by id', async () => {
        // First create one
        const createRes = await request(app)
            .post('/api/v1/posts')
            .set('Authorization', `Bearer ${token}`)
            .send({ content: 'To be fetched' });

        const postId = createRes.body.id;

        const res = await request(app)
            .get(`/api/v1/posts/${postId}`)
            .set('Authorization', `Bearer ${token}`)
            .expect(200);

        expect(res.body.id).toBe(postId);
        expect(res.body.content).toBe('To be fetched');
    });

    it('should delete a post', async () => {
        const createRes = await request(app)
            .post('/api/v1/posts')
            .set('Authorization', `Bearer ${token}`)
            .send({ content: 'To be deleted' });

        const postId = createRes.body.id;

        await request(app)
            .delete(`/api/v1/posts/${postId}`)
            .set('Authorization', `Bearer ${token}`)
            .expect(204);

        // Verify it's gone
        await request(app)
            .get(`/api/v1/posts/${postId}`)
            .set('Authorization', `Bearer ${token}`)
            .expect(404);
    });
});

