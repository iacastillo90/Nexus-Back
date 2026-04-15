const request = require('supertest');
const app = require('../../src/app');
const { User, VoiceProfile } = require('../../src/models');
const jwt = require('jsonwebtoken');
const AIFactory = require('../../src/services/ai/ai.factory');
const voiceService = require('../../src/services/voice.service');
const path = require('path');
const fs = require('fs');

// Mock AIFactory
jest.mock('../../src/services/ai/ai.factory');

// Mock QuotaService to avoid Redis dependency
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

describe('Voice Cloning Integration', () => {
    let authToken;
    let user;
    let mockProvider;

    beforeAll(async () => {
        // Create test user
        const uniqueId = Date.now();
        user = await User.create({
            username: `voiceuser_${uniqueId}`,
            email: `voice_${uniqueId}@example.com`,
            passwordHash: 'hashedpassword',
            isActive: true,
            isVerified: true,
            echoEnabled: true,
            echoPlan: 'creator'
        });

        authToken = generateToken(user);

        // Setup mock provider
        mockProvider = {
            generateAudio: jest.fn().mockResolvedValue(Buffer.from('mock_audio_data')),
            addVoice: jest.fn().mockResolvedValue('mock_elevenlabs_voice_id')
        };

        AIFactory.getProvider.mockReturnValue(mockProvider);

        // Ensure uploads directory exists for tests
        const uploadDir = 'uploads/samples/';
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir, { recursive: true });
        }
    });

    afterAll(async () => {
        if (user) {
            await VoiceProfile.destroy({ where: { userId: user.id } });
            await User.destroy({ where: { id: user.id } });
        }
    });

    describe('POST /api/v1/voice/clone', () => {
        it('should create a voice profile', async () => {
            // Create a dummy file
            const filePath = path.join('uploads/samples/', 'test_sample.mp3');
            fs.writeFileSync(filePath, 'dummy content');

            const res = await request(app)
                .post('/api/v1/voice/clone')
                .set('Authorization', `Bearer ${authToken}`)
                .field('name', 'My Test Voice')
                .attach('samples', filePath);

            expect(res.status).toBe(200);
            expect(res.body.success).toBe(true);
            expect(res.body.data).toHaveProperty('elevenLabsVoiceId');
            expect(res.body.data.status).toBe('ready');

            // Verify DB
            const profile = await VoiceProfile.findOne({ where: { userId: user.id } });
            expect(profile).toBeDefined();
            expect(profile.elevenLabsVoiceId).toContain('mock_voice_');

            // Cleanup
            fs.unlinkSync(filePath);
        });
    });

    describe('POST /api/v1/voice/speak', () => {
        it('should generate audio', async () => {
            const res = await request(app)
                .post('/api/v1/voice/speak')
                .set('Authorization', `Bearer ${authToken}`)
                .send({ text: 'Hello world' });

            expect(res.status).toBe(200);
            expect(res.header['content-type']).toBe('audio/mpeg');
            expect(res.body).toBeDefined();
        });

        it('should use cache on second request', async () => {
            // First request (already done above, but let's do explicit check)
            mockProvider.generateAudio.mockClear();

            await request(app)
                .post('/api/v1/voice/speak')
                .set('Authorization', `Bearer ${authToken}`)
                .send({ text: 'Cache test' });

            expect(mockProvider.generateAudio).toHaveBeenCalledTimes(1);

            // Second request - should hit cache
            await request(app)
                .post('/api/v1/voice/speak')
                .set('Authorization', `Bearer ${authToken}`)
                .send({ text: 'Cache test' });

            expect(mockProvider.generateAudio).toHaveBeenCalledTimes(1); // Call count should NOT increase
        });
    });
});

