process.env.NODE_ENV = 'test';
const { User, sequelize } = require('../src/models');

const logger = require('../src/utils/logger');

async function debugTestDb() {
    try {
        await sequelize.authenticate();
        logger.info('[DebugTestDB] Connected to Test DB.');

        logger.info('[DebugTestDB] Attempting to create user in Test DB...');
        const user = await User.create({
            username: 'testdebug_' + Date.now(),
            email: 'testdebug_' + Date.now() + '@example.com',
            passwordHash: 'hashedpassword',
            isActive: true,
            isVerified: true,
            echoEnabled: true,
            echoPlan: 'premium'
        });
        logger.info('[DebugTestDB] User created successfully:', user.toJSON());
    } catch (error) {
        logger.error('[DebugTestDB] Error creating user:', { error: error.message });
        if (error.original) {
            logger.error('[DebugTestDB] Original SQL Error:', {
                sqlMessage: error.original.sqlMessage,
                sql: error.original.sql
            });
        }
    } finally {
        await sequelize.close();
    }
}

debugTestDb();

