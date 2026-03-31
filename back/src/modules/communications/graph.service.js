const { User } = require('../../models');
const { pageRank } = require('../../utils/graph/pageRank');
const { getRedisClient } = require('../../config/redis');
const logger = require('../../utils/logger');
const { runGraphCalculation } = require('./graph.worker.service');
const { buildGraphFromDB } = require('./graph.builder');
const { getUserNeighborhood } = require('../../utils/graph/traversal');

const CACHE_TTL = 3600; // 1 hora
const CACHE_KEY_GRAPH = 'graph:network';

/**
 * Genera el grafo de la red social.
 * @param {Object} options - Opciones de filtrado
 * @returns {Promise<Object>} { nodes, edges, metadata }
 */
async function getNetworkGraph(options = {}) {
    try {
        const limit = options.limit || 100;
        const minInfluence = options.minInfluence || 0;
        const communityFilter = options.community;

        // Intentar obtener del caché
        const cacheKey = `${CACHE_KEY_GRAPH}:${limit}:${minInfluence}:${communityFilter || 'all'}`;
        const cached = await getCachedData(cacheKey);
        if (cached) {
            logger.info('[GraphService] Returning cached network graph');
            return cached;
        }

        logger.info('[GraphService] Cache miss. Generating graph...');
        const startTime = Date.now();

        // Construir grafo básico desde DB
        const { nodes, edges } = await buildGraphFromDB(limit);
        const graphData = { nodes, edges };

        // Ejecutar algoritmos en Worker Thread
        logger.info(`[GraphService] Spawning worker for graph calculation (${nodes.length} nodes, ${edges.length} edges)`);
        const { pageRankScores, communities, centrality, stats } = await runGraphCalculation(graphData);

        const duration = Date.now() - startTime;
        logger.info(`[GraphService] Worker finished in ${duration}ms`);

        // Enriquecer nodos con métricas
        const enrichedNodes = nodes.map(node => {
            const influence = pageRankScores[node.id] || 0;
            const community = communities[node.id] || 0;
            const degree = centrality.degree[node.id] || 0;

            return {
                ...node,
                size: Math.max(5, influence * 50), // Escalar para visualización
                color: getCommunityColor(community),
                metadata: {
                    ...node.metadata,
                    influence: parseFloat(influence.toFixed(4)),
                    community,
                    degree: parseFloat(degree.toFixed(4))
                }
            };
        });

        // Filtrar por influencia si se especifica
        let filteredNodes = enrichedNodes;
        if (minInfluence > 0) {
            filteredNodes = enrichedNodes.filter(n => n.metadata.influence >= minInfluence);
        }

        // Filtrar por comunidad si se especifica
        if (communityFilter !== undefined) {
            filteredNodes = filteredNodes.filter(n => n.metadata.community === parseInt(communityFilter));
        }

        // Filtrar edges para incluir solo nodos filtrados
        const nodeIds = new Set(filteredNodes.map(n => n.id));
        const filteredEdges = edges.filter(e => nodeIds.has(e.source) && nodeIds.has(e.target));

        const result = {
            nodes: filteredNodes,
            edges: filteredEdges,
            metadata: stats
        };

        // Cachear resultado
        await cacheData(cacheKey, result, CACHE_TTL);

        return result;
    } catch (error) {
        logger.error(`[GraphService] Error generating network graph: ${error.message}`);
        throw error;
    }
}

/**
 * Obtiene usuarios más influyentes.
 * @param {number} limit - Cantidad de usuarios
 * @returns {Promise<Object[]>} Lista de usuarios con scores
 */
async function getInfluentialUsers(limit = 10) {
    try {
        const graph = await getNetworkGraph({ limit: 1000 }); // Analizar más usuarios
        const scores = pageRank(graph);

        // Ordenar por PageRank
        const ranked = Object.entries(scores)
            .map(([userId, score]) => ({
                userId,
                influenceScore: parseFloat(score.toFixed(4))
            }))
            .sort((a, b) => b.influenceScore - a.influenceScore)
            .slice(0, limit);

        // Hidratar con datos de usuario
        const userIds = ranked.map(r => r.userId);
        const users = await User.findAll({
            where: { id: userIds },
            attributes: ['id', 'username']
        });

        const userMap = {};
        users.forEach(u => {
            userMap[u.id] = u;
        });

        return ranked.map(r => ({
            ...r,
            username: userMap[r.userId]?.username || 'Unknown'
        }));
    } catch (error) {
        logger.error(`[GraphService] Error getting influential users: ${error.message}`);
        throw error;
    }
}

/**
 * Obtiene colores para comunidades.
 */
function getCommunityColor(communityId) {
    const colors = [
        '#3498db', '#e74c3c', '#2ecc71', '#f39c12',
        '#9b59b6', '#1abc9c', '#34495e', '#e67e22'
    ];
    return colors[communityId % colors.length];
}

/**
 * Obtiene datos del caché.
 */
async function getCachedData(key) {
    try {
        const client = await getRedisClient();
        const data = await client.get(key);
        return data ? JSON.parse(data) : null;
    } catch (error) {
        logger.debug(`[GraphService] Cache miss: ${error.message}`);
        return null;
    }
}

/**
 * Guarda datos en caché.
 */
async function cacheData(key, data, ttl) {
    try {
        const client = await getRedisClient();
        await client.setEx(key, ttl, JSON.stringify(data));
    } catch (error) {
        logger.warn(`[GraphService] Cache write failed: ${error.message}`);
    }
}

module.exports = {
    getNetworkGraph,
    getUserNeighborhood,
    getInfluentialUsers
};

