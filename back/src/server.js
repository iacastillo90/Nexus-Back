const http = require('http');
const app = require('./app');
const { config } = require('./config');
const logger = require('./utils/logger');
const { syncDatabase } = require('./models');
const { initVectorIndex } = require('./config/redis');
const { initSocketIO } = require('./config/socket');
const setupSocketHandlers = require('./socket');

/**
 * @fileoverview Punto de entrada principal del servidor.
 * @module server
 */

// Crear servidor HTTP
const server = http.createServer(app);

// Sincronizar base de datos, inicializar Redis y Socket.IO, luego iniciar servidor
syncDatabase().then(async () => {
    await initVectorIndex();

    // Inicializar Socket.IO
    const io = await initSocketIO(server);
    setupSocketHandlers(io);

    server.listen(config.PORT, () => {
        logger.info(`[Server] Servidor HTTP corriendo en el puerto ${config.PORT}`);
        logger.info(`[Server] Socket.IO listo para conexiones WebSocket`);
    });
}).catch((error) => {
    logger.error(`[Server] Error al iniciar el servidor: ${error.message}`);
    process.exit(1);
});

