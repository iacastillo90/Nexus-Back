const { Challenge, ChallengeParticipant, User } = require('../../models');
const { NotFoundError, ValidationError } = require('../../utils/errors');
const logger = require('../../utils/logger');
const { Op } = require('sequelize');

class ChallengeService {
    /**
     * Creates a new challenge.
     * @param {Object} data - Challenge data
     */
    async createChallenge(data) {
        try {
            return await Challenge.create(data);
        } catch (error) {
            logger.error(`[ChallengeService] Error creating challenge: ${error.message}`);
            throw error;
        }
    }

    /**
     * Lists active challenges.
     */
    async getActiveChallenges() {
        try {
            const now = new Date();
            return await Challenge.findAll({
                where: {
                    isActive: true,
                    startDate: { [Op.lte]: now },
                    endDate: { [Op.gte]: now }
                }
            });
        } catch (error) {
            logger.error(`[ChallengeService] Error fetching active challenges: ${error.message}`);
            throw error;
        }
    }

    /**
     * Enrolls a user in a challenge.
     * @param {string} userId 
     * @param {string} challengeId 
     */
    async joinChallenge(userId, challengeId) {
        try {
            const challenge = await Challenge.findByPk(challengeId);
            if (!challenge) throw new NotFoundError('Challenge not found');

            if (!challenge.isActive) throw new ValidationError('Challenge is not active');

            // Check if already joined
            const existing = await ChallengeParticipant.findOne({
                where: { userId, challengeId }
            });

            if (existing) throw new ValidationError('User already joined this challenge');

            return await ChallengeParticipant.create({
                userId,
                challengeId,
                status: 'active',
                progress: 0
            });
        } catch (error) {
            logger.error(`[ChallengeService] Error joining challenge: ${error.message}`);
            throw error;
        }
    }

    /**
     * Updates progress for a user's active challenges.
     * @param {string} userId 
     * @param {string} actionType - e.g., 'post_sentiment'
     * @param {Object} actionData - e.g., { sentiment: 'positive' }
     */
    async updateProgress(userId, actionType, actionData) {
        try {
            // Find active participations
            const participations = await ChallengeParticipant.findAll({
                where: { userId, status: 'active' },
                include: [{ model: Challenge, as: 'challenge' }] // Ensure alias matches model definition
            });

            for (const p of participations) {
                const challenge = p.challenge || await Challenge.findByPk(p.challengeId); // Fallback if include fails
                if (!challenge) continue;

                const req = challenge.requirements;

                // Check if action matches requirement
                if (req.type === actionType) {
                    let match = false;

                    // Example logic for 'post_sentiment'
                    if (actionType === 'post_sentiment') {
                        if (req.value === actionData.sentiment) {
                            match = true;
                        }
                    }

                    if (match) {
                        p.progress += 1;

                        // Check completion
                        if (p.progress >= req.count) {
                            p.status = 'completed';
                            p.completedAt = new Date();
                            
                            // Award reward (points/badges)
                            if (challenge.reward && challenge.reward.points) {
                                const { User } = require('../../models');
                                const user = await User.findByPk(userId);
                                if (user) {
                                    user.karmaPoints = (user.karmaPoints || 0) + challenge.reward.points;
                                    await user.save();
                                    logger.info(`[ChallengeService] Awarded ${challenge.reward.points} karma points to User ${userId}`);
                                }
                            }
                            
                            logger.info(`[ChallengeService] User ${userId} completed challenge ${challenge.title}`);
                        }

                        await p.save();
                    }
                }
            }
        } catch (error) {
            logger.error(`[ChallengeService] Error updating progress: ${error.message}`);
        }
    }

    /**
     * Get user's challenges
     */
    async getUserChallenges(userId) {
        try {
            return await ChallengeParticipant.findAll({
                where: { userId },
                include: [{ model: Challenge }] // Default association
            });
        } catch (error) {
            logger.error(`[ChallengeService] Error fetching user challenges: ${error.message}`);
            throw error;
        }
    }
}

module.exports = new ChallengeService();

