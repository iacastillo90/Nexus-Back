const { Worker } = require('worker_threads');
const path = require('path');
const { config } = require('../../config');

/**
 * Ejecuta cálculos de grafo en Worker Thread separado.
 * Previene bloqueo del Event Loop en grafos grandes.
 * 
 * @param {Object} graphData - Datos del grafo (nodos y aristas)
 * @param {number} timeout - Timeout en ms
 * @returns {Promise<Object>} Resultado del cálculo
 * @throws {Error} Si el worker falla o excede timeout
 */
function runGraphCalculation(graphData, timeout = config.workers.graph.timeout) {
    const logger = require('../../utils/logger');
    logger.debug(`[GraphWorker] Starting calculation with ${graphData.nodes.length} nodes`);

    // Envolver TODO en una promesa para capturar errores síncronos del Worker
    return new Promise((resolve, reject) => {
        try {
            const workerPath = path.join(__dirname, '../workers/graph.worker.js');

            // Esta línea puede fallar síncronamente
            const worker = new Worker(workerPath, {
                workerData: graphData
            });

            const timer = setTimeout(() => {
                worker.terminate();
                const error = new Error(`Graph calculation timeout after ${timeout}ms`);
                logger.error(`[GraphWorker] ${error.message}`);
                reject(error);
            }, timeout);

            worker.on('message', (result) => {
                clearTimeout(timer);
                if (result.error) {
                    logger.error(`[GraphWorker] Calculation error: ${result.error.message}`);
                    reject(new Error(result.error.message));
                } else {
                    logger.debug('[GraphWorker] Calculation completed successfully');
                    resolve(result);
                }
            });

            worker.on('error', (error) => {
                clearTimeout(timer);
                logger.error(`[GraphWorker] Thread Error: ${error.message}`);
                reject(error);
            });

            worker.on('exit', (code) => {
                clearTimeout(timer);
                if (code !== 0) {
                    const error = new Error(`Worker stopped with exit code ${code}`);
                    logger.error(`[GraphWorker] ${error.message}`);
                    reject(error);
                }
            });

        } catch (syncError) {
            logger.error(`[GraphWorker] Initialization failed: ${syncError.message}`);
            reject(syncError);
        }
    });
}

module.exports = { runGraphCalculation };

