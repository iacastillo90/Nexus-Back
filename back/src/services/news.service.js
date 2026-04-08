const AIFactory = require('./ai/ai.factory');
const postService = require('./post.service');
const { User, Post, Sequelize } = require('../models');
const logger = require('../utils/logger');
const { Op } = require('sequelize');

/**
 * News Service - "The Theater"
 * 
 * Acts as a "Growth Hacker" bot.
 * - Monitors trending topics in the database.
 * - Generates engaging news summaries or provocative questions.
 * - Posts as "NexusNews" (or a specific bot user).
 * 
 * @module news.service
 */

const NEWS_BOT_USERNAME = 'NexusNews';

class NewsService {

    /**
     * Generates and publishes a daily briefing or breaking news.
     * 
     * @returns {Promise<Object>} The created post
     */
    async generateDailyBriefing() {
        logger.info('[NewsService] Generating daily briefing');

        try {
            // 1. Get Bot User
            const botUser = await this.getOrCreateBotUser();

            // 2. Analyze Trends (Last 24h)
            const trends = await this.analyzeTrends();

            if (!trends.hasEnoughData) {
                logger.info('[NewsService] Not enough data for news.');
                return null;
            }

            // 3. Generate Content via AI
            const provider = AIFactory.getProvider();
            const prompt = `
      You are the editor-in-chief of Nexus News.
      Based on the following trending topics from the simulation:
      ${JSON.stringify(trends.topics)}

      Write a short, engaging news flash (max 280 chars).
      Style: Cyberpunk, urgent, exciting.
      Use emojis.
      `;

            const content = await provider.generateText('You are Nexus News Bot.', prompt);

            // 4. Publish Post
            // We use postService to ensure DNA generation and notifications
            const post = await postService.createPost(
                botUser.id,
                content,
                null, // mediaUrl
                null, // location
                null, // arMetadata
                null, // mediaPath
                { checkDuplicate: false } // Don't check duplicates for bot
            );

            logger.info(`[NewsService] Published news: ${post.id}`);
            return post;

        } catch (error) {
            logger.error(`[NewsService] Failed to generate news: ${error.message}`);
            throw error;
        }
    }

    /**
     * Analyzes recent posts to find keywords/trends.
     * @private
     */
    async analyzeTrends() {
        const yesterday = new Date(Date.now() - 24 * 60 * 60 * 1000);

        const posts = await Post.findAll({
            where: {
                createdAt: { [Op.gte]: yesterday }
            },
            attributes: ['content', 'sentiment'],
            limit: 100
        });

        if (posts.length < 5) {
            return { hasEnoughData: false };
        }

        // Extract real topics using AI provider
        const text = posts.map(p => p.content).join(' \n');
        
        try {
            const provider = AIFactory.getProvider();
            const prompt = `Analyze the following social media posts and return a JSON array of the top 3-5 most discussed topics or keywords. Return ONLY a valid JSON array of strings.\n\nPosts:\n${text}`;
            
            const responseText = await provider.generateText('You are a data extraction bot.', prompt);
            const cleanJson = responseText.replace(/```json/g, '').replace(/```/g, '').trim();
            const topics = JSON.parse(cleanJson);

            return {
                hasEnoughData: true,
                topics: Array.isArray(topics) ? topics : ['Nexus', 'Simulation'],
                sentiment: 'mixed'
            };
        } catch (error) {
            logger.warn(`[NewsService] Failed to extract topics via AI, falling back to general. Error: ${error.message}`);
            return {
                hasEnoughData: true,
                topics: ['Trending', 'Community', 'Nexus'],
                sentiment: 'mixed'
            };
        }
    }

    /**
     * Gets the NexusNews user or creates it.
     * @private
     */
    async getOrCreateBotUser() {
        let user = await User.findOne({ where: { username: NEWS_BOT_USERNAME } });

        if (!user) {
            // We need to create it. 
            // Note: This might fail if we don't have a password. 
            // Ideally this is done in a seeder.
            // For now, let's assume it exists or fail gracefully.
            logger.warn(`[NewsService] Bot user ${NEWS_BOT_USERNAME} not found. Please seed it.`);
            throw new Error(`Bot user ${NEWS_BOT_USERNAME} not found`);
        }
        return user;
    }
}

module.exports = new NewsService();

