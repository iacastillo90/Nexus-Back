/**
 * Detecta comunidades usando algoritmo Louvain simplificado.
 * @param {Object} graph - { nodes: [], edges: [] }
 * @returns {Object} Map de nodeId -> communityId
 */
function louvainCommunities(graph) {
    const nodes = graph.nodes;
    const edges = graph.edges;

    if (nodes.length === 0) return {};

    // Inicializar: cada nodo en su propia comunidad
    const communities = {};
    nodes.forEach((node, idx) => {
        communities[node.id] = idx;
    });

    // Construir matriz de adyacencia
    const adjacency = {};
    nodes.forEach(node => {
        adjacency[node.id] = new Set();
    });

    edges.forEach(edge => {
        adjacency[edge.source].add(edge.target);
        adjacency[edge.target].add(edge.source); // Grafo no dirigido
    });

    // Algoritmo Louvain simplificado (una pasada)
    let improved = true;
    let iterations = 0;
    const maxIterations = 10;

    while (improved && iterations < maxIterations) {
        improved = false;
        iterations++;

        for (const node of nodes) {
            const nodeId = node.id;
            const currentCommunity = communities[nodeId];

            // Contar vecinos en cada comunidad
            const neighborCommunities = {};
            for (const neighbor of adjacency[nodeId]) {
                const comm = communities[neighbor];
                neighborCommunities[comm] = (neighborCommunities[comm] || 0) + 1;
            }

            // Encontrar la comunidad con más vecinos
            let bestCommunity = currentCommunity;
            let maxNeighbors = neighborCommunities[currentCommunity] || 0;

            for (const [comm, count] of Object.entries(neighborCommunities)) {
                if (count > maxNeighbors) {
                    maxNeighbors = count;
                    bestCommunity = parseInt(comm);
                }
            }

            // Mover a la mejor comunidad si es diferente
            if (bestCommunity !== currentCommunity) {
                communities[nodeId] = bestCommunity;
                improved = true;
            }
        }
    }

    // Renumerar comunidades consecutivamente
    const uniqueCommunities = [...new Set(Object.values(communities))];
    const communityMap = {};
    uniqueCommunities.forEach((comm, idx) => {
        communityMap[comm] = idx;
    });

    const finalCommunities = {};
    for (const [nodeId, comm] of Object.entries(communities)) {
        finalCommunities[nodeId] = communityMap[comm];
    }

    return finalCommunities;
}

module.exports = { louvainCommunities };

