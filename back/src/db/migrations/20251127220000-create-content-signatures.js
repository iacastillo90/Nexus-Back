'use strict';

module.exports = {
    /**
     * Creates content_signatures table for storing cryptographic signatures.
     */
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('content_signatures', {
            id: {
                type: Sequelize.UUID,
                defaultValue: Sequelize.UUIDV4,
                primaryKey: true
            },
            dnaHash: {
                type: Sequelize.STRING(64),
                allowNull: false,
                unique: true
            },
            authorId: {
                type: Sequelize.UUID,
                allowNull: false,
                references: {
                    model: 'users',
                    key: 'id'
                },
                onDelete: 'CASCADE'
            },
            contentText: {
                type: Sequelize.TEXT,
                allowNull: true
            },
            mediaHash: {
                type: Sequelize.STRING(64),
                allowNull: true
            },
            contentType: {
                type: Sequelize.ENUM('post', 'comment', 'message', 'audio', 'dream'),
                allowNull: false
            },
            parentId: {
                type: Sequelize.UUID,
                allowNull: true
            },
            timestamp: {
                type: Sequelize.DATE(3),
                allowNull: false
            },
            algorithm: {
                type: Sequelize.STRING(20),
                allowNull: false,
                defaultValue: 'sha256'
            },
            payload: {
                type: Sequelize.TEXT,
                allowNull: false
            },
            createdAt: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
            },
            updatedAt: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.literal('CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP')
            }
        });

        // Indexes
        await queryInterface.addIndex('content_signatures', ['dnaHash'], {
            unique: true,
            name: 'content_signatures_dna_hash_unique'
        });

        await queryInterface.addIndex('content_signatures', ['authorId'], {
            name: 'content_signatures_author_id_idx'
        });

        await queryInterface.addIndex('content_signatures', ['mediaHash'], {
            name: 'content_signatures_media_hash_idx'
        });

        await queryInterface.addIndex('content_signatures', ['contentType', 'timestamp'], {
            name: 'content_signatures_type_time_idx'
        });
    },

    /**
     * Drops content_signatures table (rollback).
     */
    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('content_signatures');
    }
};

