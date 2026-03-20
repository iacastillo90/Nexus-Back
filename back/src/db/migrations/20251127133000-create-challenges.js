'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        // Create Challenges Table
        await queryInterface.createTable('challenges', {
            id: {
                allowNull: false,
                primaryKey: true,
                type: Sequelize.UUID,
                defaultValue: Sequelize.UUIDV4
            },
            title: {
                type: Sequelize.STRING,
                allowNull: false
            },
            description: {
                type: Sequelize.TEXT,
                allowNull: true
            },
            type: {
                type: Sequelize.ENUM('daily', 'weekly', 'special'),
                defaultValue: 'daily',
                allowNull: false
            },
            requirements: {
                type: Sequelize.JSON,
                allowNull: false
            },
            reward: {
                type: Sequelize.JSON,
                allowNull: false
            },
            start_date: {
                type: Sequelize.DATE,
                allowNull: false,
                defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
            },
            end_date: {
                type: Sequelize.DATE,
                allowNull: false
            },
            is_active: {
                type: Sequelize.BOOLEAN,
                defaultValue: true
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

        // Create Challenge Participants Table
        await queryInterface.createTable('challenge_participants', {
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
            challenge_id: {
                type: Sequelize.UUID,
                allowNull: false,
                references: {
                    model: 'challenges',
                    key: 'id'
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE'
            },
            progress: {
                type: Sequelize.INTEGER,
                defaultValue: 0,
                allowNull: false
            },
            status: {
                type: Sequelize.ENUM('active', 'completed', 'failed'),
                defaultValue: 'active',
                allowNull: false
            },
            completed_at: {
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
            }
        });

        await queryInterface.addIndex('challenge_participants', ['user_id', 'challenge_id'], {
            unique: true,
            name: 'unique_user_challenge_participation'
        });
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('challenge_participants');
        await queryInterface.dropTable('challenges');
    }
};

