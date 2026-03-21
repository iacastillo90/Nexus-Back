'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('profiles', {
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
            bio: {
                type: Sequelize.TEXT,
                allowNull: true
            },
            avatar_url: {
                type: Sequelize.STRING(255),
                allowNull: true
            },
            cover_url: {
                type: Sequelize.STRING(255),
                allowNull: true
            },
            location: {
                type: Sequelize.STRING(100),
                allowNull: true
            },
            website: {
                type: Sequelize.STRING(255),
                allowNull: true
            },
            birth_date: {
                type: Sequelize.DATEONLY,
                allowNull: true
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

        await queryInterface.addIndex('profiles', ['user_id'], { unique: true });
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('profiles');
    }
};

