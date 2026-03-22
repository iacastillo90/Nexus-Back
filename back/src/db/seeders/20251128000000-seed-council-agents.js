'use strict';

const { v4: uuidv4 } = require('uuid');
const bcrypt = require('bcrypt');
const logger = require('../../utils/logger');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        const roles = await queryInterface.sequelize.query(
            `SELECT id FROM roles WHERE name = 'USER';`, // Changed 'user' to 'USER' to match default-roles seeder
            { type: queryInterface.sequelize.QueryTypes.SELECT }
        );
        const userRoleId = roles[0]?.id;

        if (!userRoleId) {
            logger.error('[Seed:Council] User role not found, cannot seed agents.');
            return;
        }

        const passwordHash = await bcrypt.hash('NexusAI_Secret_Agent_Password_2025!', 10);
        const now = new Date();

        const agents = [
            {
                id: '11111111-1111-1111-1111-111111111111',
                username: 'Dr.Luma',
                email: 'luma@nexus.ai',
                password_hash: passwordHash,
                role_id: userRoleId,
                first_name: 'Luma',
                last_name: 'AI',
                created_at: now,
                updated_at: now
            },
            {
                id: '22222222-2222-2222-2222-222222222222',
                username: 'Prof.Nova',
                email: 'nova@nexus.ai',
                password_hash: passwordHash,
                role_id: userRoleId,
                first_name: 'Nova',
                last_name: 'AI',
                created_at: now,
                updated_at: now
            },
            {
                id: '33333333-3333-3333-3333-333333333333',
                username: 'Kai',
                email: 'kai@nexus.ai',
                password_hash: passwordHash,
                role_id: userRoleId,
                first_name: 'Kai',
                last_name: 'Trickster',
                created_at: now,
                updated_at: now
            }
        ];

        const profiles = [
            {
                id: uuidv4(),
                user_id: '11111111-1111-1111-1111-111111111111',
                bio: 'Psychologist & Empath. I am here to listen and help you navigate your emotional landscape.',
                avatar_url: 'https://nexus-assets.s3.amazonaws.com/avatars/luma.png',
                created_at: now,
                updated_at: now
            },
            {
                id: uuidv4(),
                user_id: '22222222-2222-2222-2222-222222222222',
                bio: 'Futurist & Technologist. Exploring the boundaries of science and innovation.',
                avatar_url: 'https://nexus-assets.s3.amazonaws.com/avatars/nova.png',
                created_at: now,
                updated_at: now
            },
            {
                id: uuidv4(),
                user_id: '33333333-3333-3333-3333-333333333333',
                bio: 'The Jester. Life is a game, are you playing?',
                avatar_url: 'https://nexus-assets.s3.amazonaws.com/avatars/kai.png',
                created_at: now,
                updated_at: now
            }
        ];

        await queryInterface.bulkInsert('users', agents, {
            updateOnDuplicate: ['username', 'first_name', 'last_name']
        });

        await queryInterface.bulkInsert('profiles', profiles, {
            updateOnDuplicate: ['bio', 'avatar_url']
        });
    },

    async down(queryInterface, Sequelize) {
        // Delete profiles first due to FK constraint
        const agentIds = [
            '11111111-1111-1111-1111-111111111111',
            '22222222-2222-2222-2222-222222222222',
            '33333333-3333-3333-3333-333333333333'
        ];

        await queryInterface.bulkDelete('profiles', {
            user_id: agentIds
        }, {});

        await queryInterface.bulkDelete('users', {
            id: agentIds
        }, {});
    }
};

