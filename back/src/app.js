/**
 * @fileoverview Main application setup.
 * Configures Express, middlewares, and routes.
 * @module app
 */
// /Nexus-Back/src/app.js

// 1. Dependencias principales
const express = require('express');
const dotenv = require('dotenv');

// 2. Cargar variables de entorno ANTES que nada
dotenv.config();

// 3. Importar Rutas y Middlewares
const logger = require('./utils/logger'); // Nuestro logger
const mainRouter = require('./routes'); // Descomentar cuando creemos rutas
const { errorHandler } = require('./middleware/errorHandler'); // Descomentar

// Importamos nuestra configuración de BD
const { syncDatabase } = require('./models');

// 4. Creación de la instancia de Express
const app = express();

// --- Configuración de Middlewares Esenciales ---

// Middleware para parsear JSON (body-parser moderno)
app.use(express.json());

// --- Sincronizar Base de Datos ---
// syncDatabase(); // Se mueve a server.js

// Middleware para parsear 'application/x-www-form-urlencoded'
app.use(express.urlencoded({ extended: true }));

// Servir archivos estáticos (audio files y deep links)
app.use('/public', express.static('public'));
app.use('/.well-known', express.static('public/.well-known'));

// Middleware simple para loggear todas las requests (usando Winston)
app.use((req, res, next) => {
  logger.info(`[Request] ${req.method} ${req.originalUrl}`);
  next();
});

// --- Rutas de la Aplicación ---

// Endpoint de Health Check (para saber si la API está viva)
app.get('/api/v1/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    message: 'Nexus-Back API is alive and kicking! 🚀',
  });
});

// Agregador principal de rutas (ej. /api/v1/...)
app.use('/api/v1', mainRouter); // Descomentar cuando tengamos rutas

// --- Manejo de Errores ---

// Middleware para manejar 404 (Rutas no encontradas)
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: `La ruta ${req.originalUrl} no fue encontrada en Nexus-Back.`,
  });
});

// Middleware de manejo de errores global (nuestro errorHandler.js)
app.use(errorHandler); // Descomentar cuando esté implementado

// 5. Exportar la aplicación
// Esto permite que server.js la importe para iniciarla
// y que nuestros tests (Supertest) la importen para probarla.
module.exports = app;
