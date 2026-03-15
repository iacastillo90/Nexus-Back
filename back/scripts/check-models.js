const fs = require('fs');
const path = require('path');
const logger = require('../src/utils/logger');

/**
 * @fileoverview Script para verificar la estructura de los modelos.
 */

const modelsDir = path.join(__dirname, '../src/models');
const files = fs.readdirSync(modelsDir).filter(file => file.endsWith('.js') && file !== 'index.js');

logger.info(`Checking models in: ${modelsDir}`);

files.forEach(file => {
    try {
        const modelPath = path.join(modelsDir, file);
        const modelExport = require(modelPath);
        const type = typeof modelExport;
        logger.info(`${file}: ${type}`);
        if (type !== 'function') {
            logger.error(`ERROR: ${file} exports ${type}, expected function`);
        }
    } catch (error) {
        logger.error(`ERROR loading ${file}: ${error.message}`);
    }
});

