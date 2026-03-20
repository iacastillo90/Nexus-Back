'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.addColumn('users', 'echo_enabled', {
            type: Sequelize.BOOLEAN,
            defaultValue: false
        });

        await queryInterface.addColumn('users', 'echo_plan', {
            type: Sequelize.ENUM('free', 'premium', 'creator'),
            defaultValue: 'free'
        });
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.removeColumn('users', 'echo_enabled');
        await queryInterface.removeColumn('users', 'echo_plan');
    }
};

