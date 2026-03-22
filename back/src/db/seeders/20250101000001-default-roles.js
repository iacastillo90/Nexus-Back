'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        // Check if roles already exist to avoid duplicates if run multiple times
        const roles = await queryInterface.rawSelect('roles', {
            where: { name: 'user' },
        }, ['id']);

        if (!roles) {
            await queryInterface.bulkInsert('roles', [
                {
                    id: Sequelize.fn('UUID'),
                    name: 'user',
                    description: 'Usuario regular de Nexus',
                    created_at: new Date(),
                    updated_at: new Date()
                },
                {
                    id: Sequelize.fn('UUID'),
                    name: 'admin',
                    description: 'Administrador del sistema',
                    created_at: new Date(),
                    updated_at: new Date()
                },
                {
                    id: Sequelize.fn('UUID'),
                    name: 'moderator',
                    description: 'Moderador de contenido',
                    created_at: new Date(),
                    updated_at: new Date()
                }
            ], {});
        }
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.bulkDelete('roles', {
            name: ['user', 'admin', 'moderator']
        }, {});
    }
};

