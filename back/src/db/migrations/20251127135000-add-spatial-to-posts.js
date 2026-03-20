'use strict';

const logger = require('../../utils/logger');

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.addColumn('posts', 'geolocation', {
            type: Sequelize.GEOMETRY('POINT'),
            allowNull: true
        });

        await queryInterface.addColumn('posts', 'ar_metadata', {
            type: Sequelize.JSON,
            allowNull: true
        });

        // Add spatial index for performance if supported
        try {
            await queryInterface.addIndex('posts', ['geolocation'], {
                type: 'SPATIAL',
                name: 'posts_geolocation_idx'
            });
        } catch (error) {
            logger.warn(`[Migration] Spatial index creation failed: ${error.message}`);
        }
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.removeColumn('posts', 'ar_metadata');
        await queryInterface.removeColumn('posts', 'geolocation');
    }
};

