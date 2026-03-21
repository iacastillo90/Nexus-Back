'use strict';

module.exports = {
    /**
     * Adds contentDna column to posts table to store DNA Hash.
     */
    async up(queryInterface, Sequelize) {
        await queryInterface.addColumn('posts', 'contentDna', {
            type: Sequelize.STRING(64),
            allowNull: true, // Nullable for old posts
            comment: 'SHA-256 hash for authenticity verification'
        });

        // Add index for fast lookup
        await queryInterface.addIndex('posts', ['contentDna'], {
            name: 'posts_content_dna_idx'
        });
    },

    /**
     * Removes contentDna column (rollback).
     */
    async down(queryInterface, Sequelize) {
        await queryInterface.removeIndex('posts', 'posts_content_dna_idx');
        await queryInterface.removeColumn('posts', 'contentDna');
    }
};

