const EchoService = require('./echo.service');
const logger = require('../../utils/logger');

/**
 * Handler: POST /api/echo/predict
 * Predice reacción de audiencia a un post draft.
 */
async function predictReaction(req, res, next) {
    try {
        const { content } = req.body;
        const userId = req.user.id;

        const prediction = await EchoService.predictPostReaction(userId, content, {
            includeAdvice: true
        });

        logger.info('[EchoController] Prediction generated', { userId });

        res.json({
            success: true,
            data: prediction
        });
    } catch (error) {
        next(error);
    }
}

/**
 * Handler: POST /api/echo/auto-reply
 * Genera respuesta automática a un DM.
 */
async function autoReply(req, res, next) {
    try {
        const { senderId, messageContent } = req.body;
        const userId = req.user.id;

        const reply = await EchoService.generateAutoReply(userId, senderId, messageContent);

        res.json({
            success: true,
            data: reply
        });
    } catch (error) {
        next(error);
    }
}

/**
 * Handler: GET /api/echo/summarize/:postId
 * Resume un hilo de comentarios.
 */
async function summarizeComments(req, res, next) {
    try {
        const { postId } = req.params;
        const userId = req.user.id;

        const summary = await EchoService.summarizeThread(postId, userId);

        res.json({
            success: true,
            data: summary
        });
    } catch (error) {
        next(error);
    }
}

module.exports = {
    predictReaction,
    autoReply,
    summarizeComments
};

