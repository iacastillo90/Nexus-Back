const { graphStatistics } = require('./statistics');
const { User, Follow } = require('../../models');
const logger = require('../logger');

/**
 * Obtiene el vecindario de un usuario (subgrafo).
 * @param {string} userId - ID del usuario
 * @param {number} depth - Profundidad (niveles de conexiones)
 * @returns {Promise<Object>} { nodes, edges, metadata }
 */
async function getUserNeighborhood(userId, depth = 2) {
    try {
        const visited = new Set();
        const nodesToProcess = [{ id: userId, level: 0 }];
        const nodes = [];
        const edges = [];

        while (nodesToProcess.length > 0) {
            const { id, level } = nodesToProcess.shift();

            if (visited.has(id) || level > depth) continue;
            visited.add(id);

            // Obtener usuario
            const user = await User.findByPk(id, {
                attributes: ['id', 'username'],
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

            if (!user) continue;

            nodes.push({
                id: user.id,
                label: user.username,
                level,
                metadata: {
                    followers: user.followers ? user.followers.length : 0,
                    following: user.following ? user.following.length : 0
                }
            });

            // Agregar vecinos para procesar
            if (level < depth) {
                if (user.following) {
                    user.following.forEach(f => {
                        edges.push({
                            source: user.id,
                            target: f.followingId,
                            weight: 1,
                            type: 'follow'
                        });
                        nodesToProcess.push({ id: f.followingId, level: level + 1 });
                    });
                }

                if (user.followers) {
                    user.followers.forEach(f => {
                        edges.push({
                            source: f.followerId,
                            target: user.id,
                            weight: 1,
                            type: 'follow'
                        });
                        nodesToProcess.push({ id: f.followerId, level: level + 1 });
                    });
                }
            }
        }

        const graph = { nodes, edges };
        const stats = graphStatistics(graph);

        return {
            nodes,
            edges,
            metadata: {
                ...stats,
                centerNode: userId,
                depth
            }
        };
    } catch (error) {
        logger.error(`[GraphTraversal] Error getting user neighborhood: ${error.message}`);
        throw error;
    }
}

module.exports = { getUserNeighborhood };

