/**
 * @fileoverview Configuración del logger Winston para la aplicación.
 * @module utils/logger
 */

const winston = require('winston');

const { combine, timestamp, printf, colorize, align } = winston.format;

/**
 * Instancia configurada de Winston Logger.
 * 
 * Niveles de log:
 * - error: 0
 * - warn: 1
 * - info: 2
 * - http: 3
 * - verbose: 4
 * - debug: 5
 * - silly: 6
 * 
 * Formato: [YYYY-MM-DD HH:mm:ss] LEVEL: message
 */
const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: combine(
    colorize({ all: true }),
    timestamp({
      format: 'YYYY-MM-DD HH:mm:ss',
    }),
    align(),
    printf((info) => `[${info.timestamp}] ${info.level}: ${info.message}`),
  ),
  transports: [
    // Siempre loggear a la consola en desarrollo
    new winston.transports.Console(),
  ],
});

module.exports = logger;
