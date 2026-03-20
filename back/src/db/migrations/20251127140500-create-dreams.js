'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        // Create Dreams Table
        await queryInterface.createTable('dreams', {
            id: {
                type: Sequelize.UUID,
                defaultValue: Sequelize.UUIDV4,
                primaryKey: true,
                allowNull: false,
            },
            title: {
                type: Sequelize.STRING,
                allowNull: false,
            },
            theme: {
                type: Sequelize.STRING,
                allowNull: false,
            },
            current_state: {
                type: Sequelize.JSON,
                allowNull: true,
            },
            status: {
                type: Sequelize.ENUM('ACTIVE', 'COMPLETED'),
                defaultValue: 'ACTIVE',
                allowNull: false,
            },
            created_by: {
                type: Sequelize.UUID,
                allowNull: false,
                references: {
                    model: 'users',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            created_at: {
                allowNull: false,
                type: Sequelize.DATE,
            },
            updated_at: {
                allowNull: false,
                type: Sequelize.DATE,
            },
        });

        // Create Dream Contributions Table
        await queryInterface.createTable('dream_contributions', {
            id: {
                type: Sequelize.UUID,
                defaultValue: Sequelize.UUIDV4,
                primaryKey: true,
                allowNull: false,
            },
            content: {
                type: Sequelize.STRING(1000),
                allowNull: false,
            },
            sentiment: {
                type: Sequelize.STRING,
                allowNull: true,
            },
            dream_id: {
                type: Sequelize.UUID,
                allowNull: false,
                references: {
                    model: 'dreams',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            user_id: {
                type: Sequelize.UUID,
                allowNull: false,
                references: {
                    model: 'users',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            created_at: {
                allowNull: false,
                type: Sequelize.DATE,
            },
            updated_at: {
                allowNull: false,
                type: Sequelize.DATE,
            },
        });
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('dream_contributions');
        await queryInterface.dropTable('dreams');
    }
};

