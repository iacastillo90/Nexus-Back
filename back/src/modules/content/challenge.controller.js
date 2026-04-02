const challengeService = require('./challenge.service');
const logger = require('../../utils/logger');

class ChallengeController {
    /**
     * Lista los desafíos activos.
     * 
     * @param {Object} req - Express request
     * @param {Object} res - Express response
     * @param {Function} next - Express next middleware
     */
    async listChallenges(req, res, next) {
        try {
            const challenges = await challengeService.getActiveChallenges();
            res.status(200).json({
                success: true,
                data: challenges
            });
        } catch (error) {
            next(error);
        }
    }

    /**
     * Permite a un usuario unirse a un desafío.
     * 
     * @param {Object} req - Express request
     * @param {Object} res - Express response
     * @param {Function} next - Express next middleware
     */
    async joinChallenge(req, res, next) {
        try {
            const { challengeId } = req.params;
            const userId = req.user.id;

            const participation = await challengeService.joinChallenge(userId, challengeId);

            res.status(200).json({
                success: true,
                message: 'Joined challenge successfully',
                data: participation
            });
        } catch (error) {
            next(error);
        }
    }

    /**
     * Crea un nuevo desafío (Admin).
     * 
     * @param {Object} req - Express request
     * @param {Object} res - Express response
     * @param {Function} next - Express next middleware
     */
    async createChallenge(req, res, next) {
        try {
            // Admin only check should be in middleware, assuming it's passed
            const challenge = await challengeService.createChallenge(req.body);
            res.status(201).json({
                success: true,
                data: challenge
            });
        } catch (error) {
            next(error);
        }
    }

    /**
     * Obtiene los desafíos en los que participa el usuario.
     * 
     * @param {Object} req - Express request
     * @param {Object} res - Express response
     * @param {Function} next - Express next middleware
     */
    async getUserChallenges(req, res, next) {
        try {
            const userId = req.user.id;
            const challenges = await challengeService.getUserChallenges(userId);
            res.status(200).json({
                success: true,
                data: challenges
            });
        } catch (error) {
            next(error);
        }
    }
}

module.exports = new ChallengeController();

