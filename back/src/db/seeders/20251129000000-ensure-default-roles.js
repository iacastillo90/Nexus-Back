'use strict';
const { v4: uuidv4 } = require('uuid');

module.exports = {
    async up(queryInterface, Sequelize) {
        const roles = await queryInterface.sequelize.query(
            `SELECT id FROM roles WHERE name = 'user';`,
            { type: queryInterface.sequelize.QueryTypes.SELECT }
        );

        if (roles.length === 0) {
            await queryInterface.bulkInsert('roles', [
                {
                    id: uuidv4(),
                    name: 'user',
                    description: 'Usuario regular de Nexus',
                    created_at: new Date(),
                    updated_at: new Date()
                }
            ]);
        }
    },

    async down(queryInterface, Sequelize) {
        // No action needed for safety
    }
};

