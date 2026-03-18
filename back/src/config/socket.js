const { Server } = require('socket.io');
const { createAdapter } = require('@socket.io/redis-adapter');
const { getRedisClient } = require('./redis');
const logger = require('../utils/logger');

let io = null;

/**
 * Inicializa Socket.IO con Redis adapter para escalabilidad.
 * @param {import('http').Server} httpServer - Servidor HTTP
 * @returns {import('socket.io').Server} Instancia de Socket.IO
 */
async function initSocketIO(httpServer) {
    if (io) return io;

    const { config } = require('./index');

    io = new Server(httpServer, {
        cors: {
            origin: config.corsOrigin,
            methods: ['GET', 'POST'],
            credentials: true
        },
        transports: ['websocket', 'polling']
    });

    // Configurar Redis adapter para multi-servidor
    try {
        const redisClient = await getRedisClient();
        const subClient = redisClient.duplicate();
        await subClient.connect();

        io.adapter(createAdapter(redisClient, subClient));
        logger.info('[Socket.IO] Redis adapter configured');
    } catch (error) {
        logger.warn(`[Socket.IO] Redis adapter failed: ${error.message}. Running in single-server mode.`);
    }

    logger.info('[Socket.IO] Server initialized');
    return io;
}

/**
 * Obtiene la instancia de Socket.IO.
 * @returns {import('socket.io').Server}
 */
function getIO() {
    if (!io) {
        throw new Error('Socket.IO not initialized. Call initSocketIO first.');
    }
    return io;
}

module.exports = {
    initSocketIO,
    getIO
};

