'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('users', {
            id: {
                allowNull: false,
                primaryKey: true,
                type: Sequelize.UUID,
                defaultValue: Sequelize.UUIDV4
            },
            username: {
                type: Sequelize.STRING(50),
                allowNull: false,
                unique: true
            },
            first_name: {
                type: Sequelize.STRING(100),
                allowNull: true
            },
            last_name: {
                type: Sequelize.STRING(100),
                allowNull: true
            },
            email: {
                type: Sequelize.STRING(255),
                allowNull: false,
                unique: true
            },
            password_hash: {
                type: Sequelize.STRING(255),
                allowNull: false
            },
            role_id: {
                type: Sequelize.UUID,
                allowNull: true,
                references: {
                    model: 'roles',
                    key: 'id'
                },
                onUpdate: 'CASCADE',
                onDelete: 'SET NULL'
            },
            is_verified: {
                type: Sequelize.BOOLEAN,
                defaultValue: false,
                allowNull: false
            },
            is_active: {
                type: Sequelize.BOOLEAN,
                defaultValue: true,
                allowNull: false
            },
            last_login_at: {
                type: Sequelize.DATE,
                allowNull: true
            },
            email_verified_at: {
                type: Sequelize.DATE,
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

        // Add indexes
        await queryInterface.addIndex('users', ['email'], { unique: true });
        await queryInterface.addIndex('users', ['username'], { unique: true });
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('users');
    }
};

