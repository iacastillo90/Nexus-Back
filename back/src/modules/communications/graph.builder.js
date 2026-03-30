const { User, Follow } = require('../../models');

/**
 * Construye la estructura base del grafo (nodos y aristas) desde la base de datos.
 * @param {number} limit - Límite de usuarios a obtener
 * @returns {Promise<Object>} { nodes, edges }
 */
async function buildGraphFromDB(limit = 100) {
    const logger = require('../../utils/logger');
    logger.info(`[GraphBuilder] Starting graph build with limit ${limit}`);

    try {
        // Obtener usuarios
        const users = await User.findAll({
            attributes: ['id', 'username'],
            limit,
            include: [{
                model: Follow,
                as: 'followers',
                attributes: ['followerId']
            }, {
                model: Follow,
                as: 'following',
                attributes: ['followingId']
            }]
        });

        if (!users || users.length === 0) {
            logger.warn('[GraphBuilder] No users found to build graph');
            return { nodes: [], edges: [] };
        }

        // Obtener todas las relaciones de follow
        const follows = await Follow.findAll({
            attributes: ['followerId', 'followingId']
        });

        // Construir grafo básico
        const nodes = users.map(user => ({
            id: user.id,
            label: user.username,
            metadata: {
                followers: user.followers ? user.followers.length : 0,
                following: user.following ? user.following.length : 0
            }
        }));

        const edges = follows.map(follow => ({
            source: follow.followerId,
            target: follow.followingId,
            weight: 1,
            type: 'follow'
        }));

        logger.info(`[GraphBuilder] Graph built successfully: ${nodes.length} nodes, ${edges.length} edges`);
        return { nodes, edges };

    } catch (error) {
        logger.error(`[GraphBuilder] Failed to build graph: ${error.message}`, { stack: error.stack });
        throw new Error('Graph generation failed');
    }
}

module.exports = { buildGraphFromDB };

