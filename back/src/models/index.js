/**
 * @fileoverview Punto de entrada para los modelos de Sequelize.
 * Carga dinámicamente todos los modelos y establece las asociaciones.
 * @module models/index
 */
'use strict';

const fs = require('fs');
const path = require('path');
const { Sequelize, DataTypes } = require('sequelize');
const { sequelize } = require('../config');
const logger = require('../utils/logger');

const db = {};
const basename = path.basename(__filename);

logger.debug('[DB] Cargando modelos dinámicamente...');

// 1. --- Carga Dinámica de Modelos ---
fs.readdirSync(__dirname)
  .filter((file) => {
    return (
      file.indexOf('.') !== 0 &&
      file !== basename &&
      file.slice(-3) === '.js' &&
      file.indexOf('.test.js') === -1
    );
  })
  .forEach((file) => {
    const model = require(path.join(__dirname, file))(sequelize, DataTypes);
    db[model.name] = model;
    logger.debug(`[DB] Modelo cargado: ${model.name}`);
  });

// 2. --- Definición de Asociaciones ---
logger.debug('[DB] Ejecutando asociaciones de modelos...');
Object.keys(db).forEach((modelName) => {
  if (db[modelName].associate) {
    db[modelName].associate(db);
    logger.debug(`[DB] Asociaciones para ${modelName} ejecutadas.`);
  }
});

// 3. --- Exportación ---
db.sequelize = sequelize;
db.Sequelize = Sequelize;

/**
 * Sincroniza todos los modelos definidos con la base de datos.
 */
db.syncDatabase = async () => {
  try {
    // En producción, NO usar sync(). Usar migrations en su lugar.
    // Se ha deshabilitado sync() por seguridad (User Request 10/10 Refactor)
    /*
    if (process.env.NODE_ENV === 'development' && process.env.AUTO_SYNC === 'true') {
      logger.warn('[Database] AUTO_SYNC enabled - Using sequelize.sync()');
      await db.sequelize.sync({ alter: true });
      logger.info('[Database] Todos los modelos fueron sincronizados exitosamente.');
    } else {
    */
    logger.info('[Database] Using migrations for schema management (sync disabled for safety)');
    // }
  } catch (error) {
    logger.error(`[DB] Error al sincronizar modelos: ${error.message}`);
    process.exit(1); // Fail Fast
  }
};

module.exports = db;
