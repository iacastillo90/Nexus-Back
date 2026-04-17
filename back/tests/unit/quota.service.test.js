describe('QuotaService', () => {
    let QuotaService;
    let mRedisClient;
    let logger;
    let RateLimitError;

    beforeEach(() => {
        jest.resetModules();

        mRedisClient = {
            incr: jest.fn(),
            expire: jest.fn(),
            get: jest.fn()
        };

        jest.doMock('../../src/config/redis', () => ({
            getRedisClient: jest.fn(() => Promise.resolve(mRedisClient))
        }));

        jest.doMock('../../src/utils/logger', () => ({
            debug: jest.fn(),
            error: jest.fn(),
            info: jest.fn(),
            warn: jest.fn()
        }));

        QuotaService = require('../../src/services/quota.service');
        const errors = require('../../src/utils/errors');
        RateLimitError = errors.RateLimitError;
        logger = require('../../src/utils/logger');
    });

    describe('checkQuota', () => {
        it('should allow access if under limit (Free Plan)', async () => {
            mRedisClient.incr.mockResolvedValue(1);
            await QuotaService.checkQuota('user1', 'FREE', 'ECHO_PREDICTIONS');
            expect(mRedisClient.incr).toHaveBeenCalled();
        });

        it('should throw RateLimitError if over limit', async () => {
            mRedisClient.incr.mockResolvedValue(6);
            await expect(QuotaService.checkQuota('user1', 'FREE', 'ECHO_PREDICTIONS'))
                .rejects.toThrow(RateLimitError);
        });

        it('should fail open if Redis fails', async () => {
            mRedisClient.incr.mockRejectedValue(new Error('Redis connection failed'));
            await QuotaService.checkQuota('user1', 'FREE', 'ECHO_PREDICTIONS');
            expect(logger.error).toHaveBeenCalled();
        });
    });
});

