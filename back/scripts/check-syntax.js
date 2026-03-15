const fs = require('fs');
const path = require('path');
const logger = require('../src/utils/logger');

/**
 * @fileoverview Script para verificar la sintaxis de archivos clave.
 */

const filesToCheck = [
    '../src/models/index.js',
    '../src/services/userService.js',
    '../src/repositories/userRepository.js',
    '../src/repositories/roleRepository.js',
    '../src/controllers/user.controller.js',
    '../src/services/search.service.js',
    '../src/services/embedding.service.js',
    '../src/controllers/search.controller.js',
    '../src/routes/search.routes.js'
];

filesToCheck.forEach(file => {
    const filePath = path.join(__dirname, file);
    logger.info(`Checking ${filePath}...`);
    try {
        require(filePath);
        logger.info(`OK: ${file}`);
    } catch (error) {
        logger.error(`ERROR loading ${file}: ${error.message}`);
        // logger.error(error.stack);
    }
});

