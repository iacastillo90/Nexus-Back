/**
 * Construye lista de adyacencia desde nodos y aristas.
 */
function buildAdjacencyList(nodes, edges) {
    const adj = {};
    nodes.forEach(node => {
        adj[node.id] = [];
    });
    edges.forEach(edge => {
        if (adj[edge.source]) {
            adj[edge.source].push(edge.target);
        }
    });
    return adj;
}

/**
 * Calcula Closeness Centrality.
 * C(u) = (N - 1) / Sum(d(u, v))
 */
function calculateCloseness(nodes, adj) {
    const closeness = {};
    const N = nodes.length;

    nodes.forEach(startNode => {
        if (N <= 1) {
            closeness[startNode.id] = 0;
            return;
        }

        const distances = {};
        const queue = [startNode.id];
        distances[startNode.id] = 0;
        let sumDist = 0;
        let reachableNodes = 0;

        // BFS
        let head = 0;
        while (head < queue.length) {
            const u = queue[head++];
            const d = distances[u];

            const neighbors = adj[u] || [];
            for (const v of neighbors) {
                if (distances[v] === undefined) {
                    distances[v] = d + 1;
                    sumDist += distances[v];
                    reachableNodes++;
                    queue.push(v);
                }
            }
        }

        // Si no puede alcanzar a nadie, closeness es 0.
        // Normalizamos por el número de nodos alcanzables si el grafo es disconexo
        if (sumDist > 0) {
            // Fórmula estándar normalizada para grafos dirigidos
            closeness[startNode.id] = reachableNodes / sumDist * (reachableNodes / (N - 1));
        } else {
            closeness[startNode.id] = 0;
        }
    });

    return closeness;
}

/**
 * Calcula Betweenness Centrality usando algoritmo de Brandes.
 */
function calculateBetweenness(nodes, adj) {
    const betweenness = {};
    nodes.forEach(n => betweenness[n.id] = 0);

    nodes.forEach(s => {
        const S = []; // Stack
        const P = {}; // Predecessors
        const sigma = {}; // Number of shortest paths
        const d = {}; // Distance

        nodes.forEach(t => {
            P[t.id] = [];
            sigma[t.id] = 0;
            d[t.id] = -1;
        });

        sigma[s.id] = 1;
        d[s.id] = 0;

        const Q = [s.id]; // Queue

        let head = 0;
        while (head < Q.length) {
            const v = Q[head++];
            S.push(v);

            const neighbors = adj[v] || [];
            for (const w of neighbors) {
                // Path discovery
                if (d[w] < 0) {
                    Q.push(w);
                    d[w] = d[v] + 1;
                }
                // Path counting
                if (d[w] === d[v] + 1) {
                    sigma[w] += sigma[v];
                    P[w].push(v);
                }
            }
        }

        const delta = {};
        nodes.forEach(v => delta[v.id] = 0);

        // Accumulation
        while (S.length > 0) {
            const w = S.pop();
            for (const v of P[w]) {
                delta[v] += (sigma[v] / sigma[w]) * (1 + delta[w]);
            }
            if (w !== s.id) {
                betweenness[w] += delta[w];
            }
        }
    });

    // Normalizar
    const N = nodes.length;
    if (N > 2) {
        const factor = 1 / ((N - 1) * (N - 2));
        for (const id in betweenness) {
            betweenness[id] *= factor;
        }
    }

    return betweenness;
}

/**
 * Calcula métricas de centralidad.
 * @param {Object} graph - { nodes: [], edges: [] }
 * @returns {Object} { degree: {}, betweenness: {}, closeness: {} }
 */
function centralityMetrics(graph) {
    const nodes = graph.nodes;
    const edges = graph.edges;

    // Construir lista de adyacencia una vez
    const adj = buildAdjacencyList(nodes, edges);

    // Degree Centrality
    const degree = {};
    nodes.forEach(node => {
        degree[node.id] = 0;
    });

    edges.forEach(edge => {
        degree[edge.source] = (degree[edge.source] || 0) + 1;
        degree[edge.target] = (degree[edge.target] || 0) + 1;
    });

    // Normalizar degree centrality
    const maxDegree = Math.max(...Object.values(degree), 1);
    for (const nodeId in degree) {
        degree[nodeId] = degree[nodeId] / maxDegree;
    }

    // Calcular métricas complejas
    const betweenness = calculateBetweenness(nodes, adj);
    const closeness = calculateCloseness(nodes, adj);

    return {
        degree,
        betweenness,
        closeness
    };
}

module.exports = { centralityMetrics };

