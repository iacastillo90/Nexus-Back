const { louvainCommunities } = require('./communities');

/**
 * Calcula estadísticas del grafo.
 * @param {Object} graph - { nodes: [], edges: [] }
 * @returns {Object} Estadísticas
 */
function graphStatistics(graph) {
    const nodes = graph.nodes;
    const edges = graph.edges;

    const totalNodes = nodes.length;
    const totalEdges = edges.length;

    // Calcular grado promedio
    const degrees = {};
    nodes.forEach(node => {
        degrees[node.id] = 0;
    });

    edges.forEach(edge => {
        degrees[edge.source] = (degrees[edge.source] || 0) + 1;
        degrees[edge.target] = (degrees[edge.target] || 0) + 1;
    });

    const avgDegree = totalNodes > 0
        ? Object.values(degrees).reduce((a, b) => a + b, 0) / totalNodes
        : 0;

    // Detectar comunidades para contar
    const communities = louvainCommunities(graph);
    const uniqueCommunities = new Set(Object.values(communities));

    return {
        totalNodes,
        totalEdges,
        avgDegree: parseFloat(avgDegree.toFixed(2)),
        communities: uniqueCommunities.size,
        density: totalNodes > 1
            ? (2 * totalEdges) / (totalNodes * (totalNodes - 1))
            : 0
    };
}

module.exports = { graphStatistics };

