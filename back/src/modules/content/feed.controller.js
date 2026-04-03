const postService = require('./post.service');
const feedService = require('./feed.service');
const logger = require('../../utils/logger');

/**
 * @fileoverview Controlador para el Feed de noticias.
 * @module controllers/feedController
 */

/**
 * Obtiene el feed de posts paginado.
 * @param {import('express').Request} req - Objeto de solicitud Express.
 * @param {import('express').Response} res - Objeto de respuesta Express.
 * @param {import('express').NextFunction} next - Función next de Express.
 */
async function getFeed(req, res, next) {
    try {
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 20;

        const posts = await postService.getFeed(page, limit);

        res.json({
            data: posts,
            meta: {
                page,
                limit
            }
        });
    } catch (error) {
        next(error);
    }
}

async function getNeuroFeed(req, res, next) {
    try {
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 20;
        const userId = req.user.id;

        const posts = await feedService.getNeuroFeed(userId, page, limit);

        res.json({
            success: true,
            data: posts,
            meta: {
                page,
                limit
            }
        });
    } catch (error) {
        next(error);
    }
}

module.exports = {
    getFeed,
    getNeuroFeed
};

