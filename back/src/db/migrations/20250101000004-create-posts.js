'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('posts', {
            id: {
                allowNull: false,
                primaryKey: true,
                type: Sequelize.UUID,
                defaultValue: Sequelize.UUIDV4
            },
            user_id: {
                type: Sequelize.UUID,
                allowNull: false,
                references: {
                    model: 'users',
                    key: 'id'
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE'
            },
            content: {
                type: Sequelize.TEXT,
                allowNull: false
            },
            media_urls: {
                type: Sequelize.JSON,
                allowNull: true
            },
            visibility: {
                type: Sequelize.ENUM('PUBLIC', 'FOLLOWERS', 'PRIVATE'),
                defaultValue: 'PUBLIC',
                allowNull: false
            },
            created_at: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
            },
            updated_at: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.literal('CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP')
            },
            deleted_at: {
                type: Sequelize.DATE,
                allowNull: true
            }
        });

        await queryInterface.addIndex('posts', ['user_id']);
        await queryInterface.addIndex('posts', ['created_at']);
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('posts');
    }
};

