const { parentPort, workerData } = require('worker_threads');
const { pageRank } = require('../utils/graph/pageRank');
const { louvainCommunities } = require('../utils/graph/communities');
const { centralityMetrics } = require('../utils/graph/centrality');
const { graphStatistics } = require('../utils/graph/statistics');
const logger = require('../utils/logger');

/**
 * Worker Thread para cálculos intensivos de grafos.
 * Recibe datos del grafo, ejecuta algoritmos y retorna resultados.
 */

try {
    const { nodes, edges } = workerData;

    if (!nodes || !edges) {
        throw new Error('Invalid graph data: nodes and edges are required');
    }

    // Reconstruir el objeto grafo
    const graph = { nodes, edges };

    // Ejecutar algoritmos
    // Nota: Estos son operaciones síncronas pesadas que bloquearían el Event Loop principal
    const pageRankScores = pageRank(graph);
    const communities = louvainCommunities(graph);
    const centrality = centralityMetrics(graph);
    const stats = graphStatistics(graph);

    // Enviar resultados al hilo principal
    parentPort.postMessage({
        pageRankScores,
        communities,
        centrality,
        stats
    });

} catch (error) {
    // Enviar error al hilo principal
    // Serializamos el error porque algunos objetos Error no se pueden clonar directamente
    parentPort.postMessage({
        error: {
            message: error.message,
            stack: error.stack
        }
    });
}

