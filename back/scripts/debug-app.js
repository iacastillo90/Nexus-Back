/**
 * @fileoverview Script to debug the application loading process.
 * Loads the app and waits for async operations to ensure stability.
 */
const logger = require('../src/utils/logger');

try {
    logger.info('Loading app...');
    const app = require('../src/app');
    logger.info('App loaded successfully. Waiting for async ops...');
    setTimeout(() => {
        logger.info('Done waiting.');
    }, 5000);
} catch (error) {
    logger.error(`CRASH: ${error.message}`);
}

