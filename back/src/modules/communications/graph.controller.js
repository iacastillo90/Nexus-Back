const graphService = require('./graph.service');
const logger = require('../../utils/logger');

/**
 * Obtiene el grafo de la red completa.
 */
async function getNetworkGraph(req, res, next) {
    try {
        const limit = parseInt(req.query.limit) || 100;
        const minInfluence = parseFloat(req.query.minInfluence) || 0;
        const community = req.query.community;

        logger.info(`[GraphController] Getting network graph (limit: ${limit})`);

        const graph = await graphService.getNetworkGraph({
            limit,
            minInfluence,
            community
        });

        res.status(200).json(graph);
    } catch (error) {
        next(error);
    }
}

/**
 * Obtiene el vecindario de un usuario.
 */
async function getUserNeighborhood(req, res, next) {
    try {
        const { userId } = req.params;
        const depth = parseInt(req.query.depth) || 2;

        logger.info(`[GraphController] Getting neighborhood for user ${userId} (depth: ${depth})`);

        const graph = await graphService.getUserNeighborhood(userId, depth);

        res.status(200).json(graph);
    } catch (error) {
        next(error);
    }
}

/**
 * Obtiene usuarios más influyentes.
 */
async function getInfluentialUsers(req, res, next) {
    try {
        const limit = parseInt(req.query.limit) || 10;

        logger.info(`[GraphController] Getting top ${limit} influential users`);

        const influencers = await graphService.getInfluentialUsers(limit);

        res.status(200).json({
            data: influencers,
            meta: {
                total: influencers.length
            }
        });
    } catch (error) {
        next(error);
    }
}

module.exports = {
    getNetworkGraph,
    getUserNeighborhood,
    getInfluentialUsers
};

