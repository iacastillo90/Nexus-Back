'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.addColumn('posts', 'sentiment', {
            type: Sequelize.ENUM('positive', 'neutral', 'negative'),
            allowNull: true
        });

        await queryInterface.addColumn('posts', 'emotional_tone', {
            type: Sequelize.JSON,
            allowNull: true
        });
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.removeColumn('posts', 'emotional_tone');
        await queryInterface.removeColumn('posts', 'sentiment');
        // Note: Removing ENUM types in some dialects might be tricky, but for now this is sufficient.
    }
};

