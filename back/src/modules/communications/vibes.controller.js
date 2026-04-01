const vibesService = require('./vibes.service');
const logger = require('../../utils/logger');

class VibesController {
    /**
     * Obtiene el dashboard de vibras del usuario.
     * 
     * Retorna estadísticas de sentimiento y tono emocional
     * basadas en la actividad reciente del usuario.
     * 
     * @param {Object} req - Express request
     * @param {Object} res - Express response
     * @param {Function} next - Express next middleware
     */
    async getDashboard(req, res, next) {
        try {
            const userId = req.user.id;
            const stats = await vibesService.getUserVibes(userId);

            res.status(200).json({
                success: true,
                data: stats
            });
        } catch (error) {
            next(error);
        }
    }

    /**
     * Obtiene las vibras globales de la comunidad.
     * 
     * Agrega estadísticas de todos los posts recientes para
     * mostrar el "pulso" emocional de la plataforma.
     * 
     * @param {Object} req - Express request
     * @param {Object} res - Express response
     * @param {Function} next - Express next middleware
     */
    async getCommunityVibes(req, res, next) {
        try {
            const stats = await vibesService.getCommunityVibes();

            res.status(200).json({
                success: true,
                data: stats
            });
        } catch (error) {
            next(error);
        }
    }
}

module.exports = new VibesController();

