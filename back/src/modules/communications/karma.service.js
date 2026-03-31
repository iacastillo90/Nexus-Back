const { User } = require('../../models');
const { getRedisClient } = require('../../config/redis');
const logger = require('../../utils/logger');
const karmaCalculator = require('../../utils/calculators/karma.calculator');

const KARMA_TIERS = {
    VERIFIED: {
        minScore: 750,
        color: 'green',
        name: 'Verified Human',
        emoji: '✓',
        privileges: ['voice_clone', 'reality_layers', 'auto_reply', 'priority_support']
    },
    ESTABLISHED: {
        minScore: 400,
        color: 'yellow',
        name: 'Established',
        emoji: '⭐',
        privileges: ['voice_clone', 'reality_layers']
    },
    NEWCOMER: {
        minScore: 200,
        color: 'orange',
        name: 'Newcomer',
        emoji: '🌱',
        privileges: []
    },
    SUSPICIOUS: {
        minScore: 0,
        color: 'red',
        name: 'Unverified',
        emoji: '⚠️',
        privileges: []
    }
};

/**
 * Helper privado para caché (necesario para el calculator)
 */
async function getCachedKarma(userId) {
    try {
        const redis = await getRedisClient();
        const cached = await redis.get(`karma:${userId}`);
        return cached ? JSON.parse(cached) : null;
    } catch (e) { return null; }
}

async function calculateKarmaScore(userId, options = {}) {
    const { forceRecalculate = false, detailed = false } = options;
    try {
        const user = await User.findByPk(userId);
        if (!user) throw new Error(`User ${userId} not found`);

        if (!forceRecalculate) {
            const cached = await getCachedKarma(userId);
            if (cached) return cached;
        }

        // Delegar cálculos complejos al Calculator
        const [pageRank, age, engagement, trust] = await Promise.all([
            karmaCalculator.calculatePageRankComponent(userId),
            karmaCalculator.calculateAccountAgeComponent(user),
            karmaCalculator.calculateEngagementComponent(userId),
            karmaCalculator.calculateTrustComponent(userId, getCachedKarma) // Pasamos la función de caché
        ]);

        const totalScore = Math.round(pageRank * 0.4 + age * 0.2 + engagement * 0.2 + trust * 0.2);
        const normalizedScore = Math.min(Math.max(totalScore, 0), 1000);
        const tier = determineTier(normalizedScore);
        const tierData = KARMA_TIERS[tier];

        const karmaData = {
            score: normalizedScore,
            color: tierData.color,
            tier: tier,
            emoji: tierData.emoji,
            name: tierData.name,
            privileges: tierData.privileges,
            lastUpdated: new Date(),
            ...(detailed && {
                breakdown: {
                    pageRankScore: Math.round(pageRank * 0.4),
                    accountAgeScore: Math.round(age * 0.2),
                    engagementScore: Math.round(engagement * 0.2),
                    trustScore: Math.round(trust * 0.2)
                }
            })
        };

        await cacheKarma(userId, karmaData);

        return karmaData;

    } catch (error) {
        logger.error('[KarmaService] Error:', { error: error.message });
        throw error;
    }
}

async function cacheKarma(userId, karmaData) {
    try {
        const redis = await getRedisClient();
        await redis.setEx(`karma:${userId}`, 3600, JSON.stringify(karmaData));
    } catch (error) {
        logger.error('[KarmaService] Failed to cache karma', { error: error.message });
    }
}

function determineTier(score) {
    if (score >= 750) return 'VERIFIED';
    if (score >= 400) return 'ESTABLISHED';
    if (score >= 200) return 'NEWCOMER';
    return 'SUSPICIOUS';
}

async function getKarmaLeaderboard(options = {}) {
    // Implementation for leaderboard...
    return [];
}

module.exports = {
    calculateKarmaScore,
    getKarmaLeaderboard,
    KARMA_TIERS
};

