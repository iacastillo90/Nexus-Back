/**
 * Calcula PageRank para un grafo.
 * @param {Object} graph - { nodes: [], edges: [] }
 * @param {number} iterations - Número de iteraciones (default: 20)
 * @param {number} dampingFactor - Factor de amortiguación (default: 0.85)
 * @returns {Object} Map de nodeId -> pageRank score
 */
function pageRank(graph, iterations = 20, dampingFactor = 0.85) {
    const nodes = graph.nodes;
    const edges = graph.edges;

    if (nodes.length === 0) return {};

    // Inicializar scores
    const scores = {};
    const outDegree = {};

    nodes.forEach(node => {
        scores[node.id] = 1.0 / nodes.length;
        outDegree[node.id] = 0;
    });

    // Calcular out-degree (cuántos enlaces salen de cada nodo)
    edges.forEach(edge => {
        outDegree[edge.source] = (outDegree[edge.source] || 0) + 1;
    });

    // Iteraciones de PageRank
    for (let iter = 0; iter < iterations; iter++) {
        const newScores = {};

        // Inicializar con el factor de teleportación
        nodes.forEach(node => {
            newScores[node.id] = (1 - dampingFactor) / nodes.length;
        });

        // Distribuir scores a través de los enlaces
        edges.forEach(edge => {
            const contribution = scores[edge.source] / (outDegree[edge.source] || 1);
            newScores[edge.target] = (newScores[edge.target] || 0) + dampingFactor * contribution;
        });

        // Actualizar scores
        Object.assign(scores, newScores);
    }

    return scores;
}

module.exports = { pageRank };

