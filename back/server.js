// /Nexus-Back/server.js

// 1. Importar la configuración de la aplicación (Express)
const app = require('./src/app');

// 2. Importar nuestro logger
const logger = require('./src/utils/logger');

// 3. Importar la configuración de variables de entorno
// NOTA: Hacemos esto aquí y en app.js para asegurar que 'dotenv'
// se cargue ANTES que cualquier otro módulo que pueda necesitarlo.
require('dotenv').config();

/**
 * Puerto del servidor.
 * Se obtiene de las variables de entorno (process.env.PORT).
 * Si no está definida, se usa 3000 como valor por defecto.
 * @type {number}
 */
const PORT = process.env.PORT || 3000;

/**
 * Inicia el servidor de la aplicación.
 *
 * Esta función es el único punto de entrada de la aplicación.
 * Escucha en el puerto definido y registra el inicio usando el logger.
 */
function startServer() {
  try {
    app.listen(PORT, () => {
      // Usamos nuestro logger (Winston)
      logger.info(
        `[NexusCore] Servidor corriendo exitosamente en http://localhost:${PORT}`,
      );
    });

    process.on('SIGINT', () => {
      logger.info('[NexusCore] Servidor apagándose...');
      process.exit(0);
    });
  } catch (error) {
    logger.error(`[NexusCore] Error al iniciar el servidor: ${error.message}`);
    process.exit(1); // Salir con código de error
  }
}

// ¡Arrancamos!
startServer();

