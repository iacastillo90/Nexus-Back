'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        // Add performance indexes that might have been missed

        // Users: search by username/email is already unique indexed.
        // Users: sort by created_at
        await queryInterface.addIndex('users', ['created_at']);

        // Posts: already indexed author_id and created_at in create-posts.

        // Comments: sort by created_at
        await queryInterface.addIndex('comments', ['created_at']);

        // Notifications: sort by created_at
        await queryInterface.addIndex('notifications', ['created_at']);

        // Messages: sort by created_at
        await queryInterface.addIndex('messages', ['created_at']);
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.removeIndex('users', ['created_at']);
        await queryInterface.removeIndex('comments', ['created_at']);
        await queryInterface.removeIndex('notifications', ['created_at']);
        await queryInterface.removeIndex('messages', ['created_at']);
    }
};

