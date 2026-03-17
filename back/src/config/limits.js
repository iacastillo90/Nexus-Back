/**
 * Configuration for usage limits.
 * Defines the maximum number of allowed actions per day for each tier.
 */

const LIMITS = {
    FREE: {
        ECHO_PREDICTIONS: 5,
        VOICE_CLONING: 0, // Not available in free tier
        SEMANTIC_SEARCH: 10,
        AUTO_REPLY: 0, // Not available in free tier
    },
    PREMIUM: {
        ECHO_PREDICTIONS: 100, // Effectively unlimited for normal use
        VOICE_CLONING: 10,
        SEMANTIC_SEARCH: 1000,
        AUTO_REPLY: 50,
    },
    CREATOR: {
        ECHO_PREDICTIONS: 1000,
        VOICE_CLONING: 50,
        SEMANTIC_SEARCH: 10000,
        AUTO_REPLY: 500,
    }
};

module.exports = LIMITS;

