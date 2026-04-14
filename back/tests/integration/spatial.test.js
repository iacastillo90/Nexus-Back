const request = require('supertest');
const { User, Post } = require('../../src/models');
const jwt = require('jsonwebtoken');

// Mock QuotaService
jest.mock('../../src/services/quota.service', () => ({
    checkQuota: jest.fn().mockResolvedValue(true),
    getUsage: jest.fn().mockResolvedValue(0)
}));

// Mock AIFactory
jest.mock('../../src/services/ai/ai.factory', () => ({
    getProvider: jest.fn().mockReturnValue({
        generateText: jest.fn().mockResolvedValue(JSON.stringify({ sentiment: 'neutral', emotionalTone: {} })),
        generateEmbedding: jest.fn().mockResolvedValue([])
    })
}));

// Mock CacheService
jest.mock('../../src/services/cache.service', () => ({
    invalidate: jest.fn().mockResolvedValue(true),
    get: jest.fn().mockResolvedValue(null),
    set: jest.fn().mockResolvedValue(true)
}));

// Mock Redis Config
jest.mock('../../src/config/redis', () => ({
    getRedisClient: jest.fn().mockResolvedValue({
        get: jest.fn(),
        set: jest.fn(),
        del: jest.fn(),
        keys: jest.fn()
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

describe('Reality Layers Integration', () => {
    let authToken;
    let user;

    beforeAll(async () => {
        // Create test user
        const uniqueId = Date.now();
        user = await User.create({
            username: `spatial_${uniqueId}`,
            email: `spatial_${uniqueId}@example.com`,
            passwordHash: 'hashedpassword',
            isActive: true,
            isVerified: true
        });

        authToken = generateToken(user);
    });

    afterAll(async () => {
        if (user) {
            await Post.destroy({ where: { userId: user.id } });
            await User.destroy({ where: { id: user.id } });
        }
    });

    describe('Spatial Posts', () => {
        it('should create a post with location', async () => {
            const res = await request(app)
                .post('/api/v1/posts')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    content: 'Hello from Times Square!',
                    location: { lat: 40.7580, lng: -73.9855 },
                    arMetadata: { anchorType: 'plane' }
                });

            expect(res.status).toBe(201);
            expect(res.body.geolocation).toBeDefined();
            expect(res.body.geolocation.coordinates).toEqual([-73.9855, 40.7580]); // GeoJSON: [lng, lat]
            // My service implementation: coordinates: [location.lat, location.lng] -> This might be wrong order for GeoJSON standard (lng, lat).
            // Let's verify what comes back.
        });

        it('should find posts nearby', async () => {
            // Create another post nearby
            await request(app)
                .post('/api/v1/posts')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    content: 'Nearby post',
                    location: { lat: 40.7581, lng: -73.9856 } // Very close
                });

            // Create far post
            await request(app)
                .post('/api/v1/posts')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    content: 'Far away post',
                    location: { lat: 34.0522, lng: -118.2437 } // Los Angeles
                });

            const res = await request(app)
                .get('/api/v1/posts/nearby')
                .query({ lat: 40.7580, lng: -73.9855, radius: 1000 }) // 1km radius
                .set('Authorization', `Bearer ${authToken}`);

            expect(res.status).toBe(200);
            expect(res.body.success).toBe(true);
            expect(res.body.data.length).toBeGreaterThanOrEqual(1);

            // Should find the nearby ones but not the far one
            const contents = res.body.data.map(p => p.content);
            expect(contents).toContain('Hello from Times Square!');
            expect(contents).toContain('Nearby post');
            expect(contents).not.toContain('Far away post');
        });
    });
});

