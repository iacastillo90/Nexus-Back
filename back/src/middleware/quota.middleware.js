const QuotaService = require('../services/quota.service');
const logger = require('../utils/logger');

/**
 * Middleware factory to check quota for a specific action.
 * @param {string} action - The action key from LIMITS config (e.g. 'ECHO_PREDICTIONS')
 */
const checkQuota = (action) => {
    return async (req, res, next) => {
        try {
            const userId = req.user.id;
            // Assuming user plan is populated in req.user, or we fetch it.
            // Ideally req.user from auth middleware has the plan.
            // If not, we might need to fetch it or default to 'free'.
            // Let's assume req.user.echoPlan or req.user.plan exists.
            // Based on the prompt, we added 'echoPlan' to User model.
            // We need to ensure auth middleware populates this.

            const userPlan = req.user.echoPlan || 'free';

            await QuotaService.checkQuota(userId, userPlan, action);
            next();
        } catch (error) {
            next(error);
        }
    };
};

module.exports = { checkQuota };

