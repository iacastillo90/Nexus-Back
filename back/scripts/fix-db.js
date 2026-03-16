/**
 * @fileoverview Database maintenance script.
 * Drops tables and cleans migration history to reset the DB state.
 */
const { Sequelize } = require('sequelize');
const config = require('../src/config/database.js')['development'];
const logger = require('../src/utils/logger');

const sequelize = new Sequelize(config.database, config.username, config.password, {
    host: config.host,
    dialect: config.dialect,
    logging: (msg) => logger.debug(msg)
});

async function fixDb() {
    try {
        await sequelize.authenticate();
        logger.info('[FixDB] Connected to DB.');

        const tables = [
            'post_tags', 'tags', 'reports', 'bookmarks', 'blocks',
            'messages', 'conversation_participants', 'conversations',
            'notifications', 'follows', 'likes', 'comments', 'posts'
        ];

        for (const table of tables) {
            logger.info(`[FixDB] Dropping ${table} table...`);
            await sequelize.getQueryInterface().dropTable(table);
            logger.info(`[FixDB] ${table} table dropped.`);
        }

        logger.info('[FixDB] Cleaning SequelizeMeta...');
        const migrations = [
            '20250101000004-create-posts.js',
            '20250101000005-create-comments.js',
            '20250101000006-create-likes.js',
            '20250101000007-create-follows.js',
            '20250101000008-create-notifications.js',
            '20250101000009-create-conversations.js',
            '20250101000010-create-conversation-participants.js',
            '20250101000011-create-messages.js',
            '20250101000012-create-blocks.js',
            '20250101000013-create-bookmarks.js',
            '20250101000014-create-reports.js',
            '20250101000015-create-tags.js',
            '20250101000016-create-post-tags.js',
            '20250101000017-add-indexes.js',
            '20251127123000-add-echo-fields-to-users.js'
        ];

        await sequelize.query(`DELETE FROM SequelizeMeta WHERE name IN (:migrations)`, {
            replacements: { migrations }
        });
        logger.info('[FixDB] SequelizeMeta cleaned.');

        // Also drop likes if needed, as it depends on comments/posts?
        // But likes migration hasn't run yet (it's 06).

    } catch (error) {
        logger.error('[FixDB] Error:', { error: error.message, stack: error.stack });
    } finally {
        await sequelize.close();
    }
}

fixDb();

