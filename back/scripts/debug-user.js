/**
 * @fileoverview Debug script for User creation.
 * Creates a test user to verify DB connection and model definition.
 */
const { User } = require('../src/models');
const logger = require('../src/utils/logger');

async function debugUser() {
    try {
        logger.info('[DebugUser] Attempting to create user...');
        const user = await User.create({
            username: 'debuguser_' + Date.now(),
            email: 'debug_' + Date.now() + '@example.com',
            passwordHash: 'hashedpassword',
            isActive: true,
            isVerified: true,
            echoEnabled: true,
            echoPlan: 'premium'
        });
        logger.info('[DebugUser] User created successfully:', user.toJSON());
    } catch (error) {
        logger.error('[DebugUser] Error creating user:', { error: error.message });
        if (error.original) {
            logger.error('[DebugUser] Original SQL Error:', {
                sqlMessage: error.original.sqlMessage,
                sql: error.original.sql
            });
        }
    }
}

debugUser();

