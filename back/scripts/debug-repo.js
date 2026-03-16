/**
 * @fileoverview Debug script for Repository layer.
 * Tests repository methods in isolation.
 */
const { findAllByIds } = require('../src/repositories/post.repository');
const logger = require('../src/utils/logger');

async function test() {
    try {
        logger.info('Testing findAllByIds...');
        // We don't expect this to work without DB connection, but we want to see if it crashes on import or call
        await findAllByIds(['1']);
    } catch (error) {
        logger.error(`Error: ${error.message}`, { stack: error.stack });
    }
}

test();

