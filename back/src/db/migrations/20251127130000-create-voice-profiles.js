'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('voice_profiles', {
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
                onDelete: 'CASCADE',
                unique: true
            },
            eleven_labs_voice_id: {
                type: Sequelize.STRING,
                allowNull: true
            },
            status: {
                type: Sequelize.ENUM('pending', 'processing', 'ready', 'failed'),
                defaultValue: 'pending',
                allowNull: false
            },
            samples: {
                type: Sequelize.JSON,
                defaultValue: [],
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
            }
        });

        await queryInterface.addIndex('voice_profiles', ['user_id']);
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('voice_profiles');
    }
};

