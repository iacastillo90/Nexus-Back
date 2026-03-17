const { Sequelize } = require('sequelize');
const logger = require('../utils/logger');
require('dotenv').config();

const { cleanEnv, str, port, num } = require('envalid');

const env = cleanEnv(process.env, {
  PORT: port({ default: 3000 }),
  DB_HOST: str({ default: 'localhost' }),
  DB_PORT: num({ default: 3306 }),
  DB_USER: str(),
  DB_PASSWORD: str(),
  DB_NAME: str(),
  LOG_LEVEL: str({ default: 'info' }),
  GRAPH_WORKER_TIMEOUT: num({ default: 30000 }),
  MAX_GRAPH_WORKERS: num({ default: 4 }),
  JWT_SECRET: str(),
  JWT_EXPIRES_IN: str({ default: '24h' }),
  STRIPE_SECRET_KEY: str(),
  PAYPAL_CLIENT_ID: str(),
  PAYPAL_CLIENT_SECRET: str(),
  REVENUECAT_WEBHOOK_AUTH: str(),
  OPENAI_API_KEY: str(),
  ELEVENLABS_API_KEY: str({ default: '' }),
  GEMINI_API_KEY: str({ default: '' }),
  AI_PROVIDER: str({ default: 'openai' }),
  AI_AUDIO_PROVIDER: str({ default: 'openai' }),
  CORS_ORIGIN: str({ default: 'http://localhost:3000' }),
});

/**
 * Configuración centralizada de la aplicación.
 */
const config = {
  PORT: env.PORT,
  db: {
    host: env.DB_HOST,
    port: env.DB_PORT,
    user: env.DB_USER,
    password: env.DB_PASSWORD,
    name: env.DB_NAME,
  },
  logLevel: env.LOG_LEVEL,
  workers: {
    graph: {
      timeout: env.GRAPH_WORKER_TIMEOUT,
      maxConcurrent: env.MAX_GRAPH_WORKERS
    }
  },
  jwt: {
    secret: env.JWT_SECRET,
    expiresIn: env.JWT_EXPIRES_IN,
  },
  payments: {
    stripeSecret: env.STRIPE_SECRET_KEY,
    paypalClientId: env.PAYPAL_CLIENT_ID,
    paypalClientSecret: env.PAYPAL_CLIENT_SECRET,
    revenuecatAuth: env.REVENUECAT_WEBHOOK_AUTH,
  },
  ai: {
    openaiKey: env.OPENAI_API_KEY,
    elevenlabsKey: env.ELEVENLABS_API_KEY,
    geminiKey: env.GEMINI_API_KEY,
    provider: env.AI_PROVIDER,
    audioProvider: env.AI_AUDIO_PROVIDER,
  },
  corsOrigin: env.CORS_ORIGIN,
  isDevelopment: process.env.NODE_ENV !== 'production'
};

/**
 * Instancia global de Sequelize.
 */
const sequelize = new Sequelize(
  config.db.name,
  config.db.user,
  config.db.password,
  {
    host: config.db.host,
    dialect: 'mysql',
    port: config.db.port,
    logging: (msg) => logger.debug(`[Sequelize] ${msg}`),
  },
);

/**
 * Prueba la conexión con la base de datos.
 */
const testDbConnection = async () => {
  try {
    await sequelize.authenticate();
    logger.info(`[DB] Conexión a '${config.db.name}' establecida exitosamente.`);
  } catch (error) {
    logger.error(`[DB] Error al conectar a la base de datos: ${error.message}`);
    process.exit(1);
  }
};

module.exports = {
  config,
  sequelize,
  testDbConnection,
};
