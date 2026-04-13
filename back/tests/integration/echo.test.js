const logger = require('../../src/utils/logger');

// ... imports

describe('Echo Features Integration', () => {
    // ... setup

    describe('POST /api/v1/echo/predict', () => {
        it('should predict post reactions successfully', async () => {
            const res = await request(app)
                .post('/api/v1/echo/predict')
                .set('Authorization', `Bearer ${authToken}`)
                .send({ content: 'This is a test post about happiness' });

            if (res.status !== 200) {
                logger.error('[EchoTest] Predict Error:', { body: res.body });
            }
            expect(res.status).toBe(200);

            expect(res.body.success).toBe(true);
            expect(res.body.data).toHaveProperty('estimatedLikes');
            expect(res.body.data).toHaveProperty('sentiment');
            expect(res.body.data.sentiment).toBe('positive');
        });

        // ...
    });

    describe('POST /api/v1/echo/auto-reply', () => {
        it('should generate auto-reply', async () => {
            mockProvider.generateText.mockResolvedValueOnce("Thanks for reaching out!");

            const res = await request(app)
                .post('/api/v1/echo/auto-reply')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    senderId: '123e4567-e89b-12d3-a456-426614174000', // Mock UUID
                    messageContent: 'Hello there!'
                });

            if (res.status !== 200) {
                logger.error('[EchoTest] Auto-reply Error:', { body: res.body });
            }
            expect(res.status).toBe(200);

            expect(res.body.success).toBe(true);
            expect(res.body.data.reply).toBe("Thanks for reaching out!");
        });
    });
});

