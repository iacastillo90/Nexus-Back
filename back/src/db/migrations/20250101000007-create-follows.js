'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('follows', {
            id: {
                allowNull: false,
                primaryKey: true,
                type: Sequelize.UUID,
                defaultValue: Sequelize.UUIDV4
            },
            follower_id: {
                type: Sequelize.UUID,
                allowNull: false,
                references: {
                    model: 'users',
                    key: 'id'
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE'
            },
            following_id: {
                type: Sequelize.UUID,
                allowNull: false,
                references: {
                    model: 'users',
                    key: 'id'
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE'
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
            }
        });

        await queryInterface.addIndex('follows', ['follower_id', 'following_id'], { unique: true });
        await queryInterface.addIndex('follows', ['follower_id']);
        await queryInterface.addIndex('follows', ['following_id']);
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('follows');
    }
};

