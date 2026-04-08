const { getRedisClient } = require('../config/redis');
const LIMITS = require('../config/limits');
const logger = require('../utils/logger');
const { RateLimitError } = require('../utils/errors');

class QuotaService {
    /**
     * Checks if a user has sufficient quota for a specific action.
     * Increments the usage counter if quota is available.
     * @param {string} userId - The user ID.
     * @param {string} plan - The user's plan ('free', 'premium', 'creator').
     * @param {string} action - The action key (e.g., 'ECHO_PREDICTIONS').
     * @throws {RateLimitError} If quota is exceeded.
     */
    static async checkQuota(userId, plan, action) {
        const userPlan = plan ? plan.toUpperCase() : 'FREE';
        const limit = LIMITS[userPlan]?.[action];

        // If limit is undefined or 0, feature is not available
        if (limit === undefined || limit === 0) {
            throw new RateLimitError(`This feature is not available in your ${userPlan} plan.Upgrade to Premium!`);
        }

        // If limit is -1 or very high, it's unlimited (though we use high numbers in config)
        if (limit > 100000) return;

        try {
            const date = new Date().toISOString().split('T')[0];
            const key = `quota:${userId}:${action}:${date}`;

            const client = await getRedisClient();

            // Atomic increment
            const currentUsage = await client.incr(key);

            // Set expiry for 24 hours if it's a new key (1st usage)
            if (currentUsage === 1) {
                await client.expire(key, 86400);
            }

            logger.debug(`[QuotaService] User ${userId} usage for ${action}: ${currentUsage}/${limit}`);

            if (currentUsage > limit) {
                throw new RateLimitError(`Daily limit reached for ${action}. Limit: ${limit}. Upgrade to increase limits.`);
            }
        } catch (error) {
            // Re-throw RateLimitError as it's a business logic error
            if (error instanceof RateLimitError) {
                throw error;
            }

            // Fail-Open: If Redis fails, log error but allow access
            logger.error(`[QuotaService] Redis error, allowing access (Fail-Open): ${error.message}`);
            return;
        }
    }

    /**
     * Gets current usage for a specific action.
     */
    static async getUsage(userId, action) {
        try {
            const date = new Date().toISOString().split('T')[0];
            const key = `quota:${userId}:${action}:${date}`;
            const client = await getRedisClient();
            const usage = await client.get(key);
            return parseInt(usage || '0', 10);
        } catch (error) {
            logger.error(`[QuotaService] Error fetching usage (returning 0): ${error.message}`);
            return 0; // Fallback seguro para UI
        }
    }
}

module.exports = QuotaService;

