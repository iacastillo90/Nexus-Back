const { Post, User, Sequelize } = require('../../models');
const AIFactory = require('./ai/ai.factory');
const logger = require('../../utils/logger');
const { Op } = require('sequelize');

class VibesService {
    /**
     * Analyzes the sentiment of a post using the AI provider.
     * @param {string} postId - ID of the post to analyze
     */
    async analyzePostSentiment(postId) {
        try {
            const post = await Post.findByPk(postId);
            if (!post || !post.content) return;

            const provider = AIFactory.getProvider();
            const prompt = `Analyze the sentiment and emotional tone of the following social media post. 
            Return a JSON object with:
            - sentiment: "positive", "neutral", or "negative"
            - emotionalTone: object with keys like joy, anger, sadness, fear, surprise, disgust and values 0-1.
            
            Post: "${post.content}"`;

            const response = await provider.generateText('You are an expert sentiment analyzer. Output only valid JSON.', prompt);

            // Clean response (remove markdown code blocks if any)
            const jsonStr = response.replace(/```json/g, '').replace(/```/g, '').trim();
            const analysis = JSON.parse(jsonStr);

            post.sentiment = analysis.sentiment;
            post.emotionalTone = analysis.emotionalTone;
            await post.save();

            logger.info(`[VibesService] Analyzed post ${postId}: ${post.sentiment}`);

            // Trigger Challenge Update
            const challengeService = require('./challenge.service');
            await challengeService.updateProgress(post.userId, 'post_sentiment', {
                sentiment: post.sentiment
            });

        } catch (error) {
            logger.error(`[VibesService] Error analyzing post ${postId}: ${error.message}`);
        }
    }

    /**
     * Calculates the user's "Vibe Score" and top emotions.
     * @param {string} userId - User ID
     * @returns {Promise<Object>} Vibe stats
     */
    async getUserVibes(userId) {
        try {
            const posts = await Post.findAll({
                where: {
                    userId,
                    sentiment: { [Op.not]: null }
                },
                attributes: ['sentiment', 'emotionalTone']
            });

            if (posts.length === 0) {
                return {
                    vibeScore: 50, // Neutral start
                    topEmotions: {},
                    sentimentDistribution: { positive: 0, neutral: 0, negative: 0 }
                };
            }

            let totalScore = 0;
            const distribution = { positive: 0, neutral: 0, negative: 0 };
            const emotionAgg = {};

            posts.forEach(post => {
                // Sentiment Score
                if (post.sentiment === 'positive') {
                    totalScore += 10;
                    distribution.positive++;
                } else if (post.sentiment === 'negative') {
                    totalScore -= 5; // Negative impact is usually stronger but let's be gentle
                    distribution.negative++;
                } else {
                    distribution.neutral++;
                }

                // Emotional Tone Aggregation
                if (post.emotionalTone) {
                    Object.entries(post.emotionalTone).forEach(([emotion, score]) => {
                        emotionAgg[emotion] = (emotionAgg[emotion] || 0) + score;
                    });
                }
            });

            // Normalize Vibe Score (0-100)
            // Simple heuristic: Base 50 + (Positive * 2) - (Negative * 2)
            // Clamped between 0 and 100
            let vibeScore = 50 + (distribution.positive * 5) - (distribution.negative * 5);
            vibeScore = Math.max(0, Math.min(100, vibeScore));

            // Top Emotions (Average)
            const topEmotions = {};
            Object.keys(emotionAgg).forEach(key => {
                topEmotions[key] = parseFloat((emotionAgg[key] / posts.length).toFixed(2));
            });

            return {
                vibeScore,
                sentimentDistribution: distribution,
                topEmotions
            };
        } catch (error) {
            logger.error(`[VibesService] Error fetching user vibes: ${error.message}`);
            throw error;
        }
    }

    /**
     * Gets global community vibe trends.
     */
    async getCommunityVibes() {
        try {
            // This could be cached or pre-calculated for performance
            const distribution = await Post.findAll({
                attributes: [
                    'sentiment',
                    [Sequelize.fn('COUNT', Sequelize.col('sentiment')), 'count']
                ],
                where: { sentiment: { [Op.not]: null } },
                group: ['sentiment'],
                raw: true
            });

            const stats = { positive: 0, neutral: 0, negative: 0 };
            distribution.forEach(row => {
                if (row.sentiment) stats[row.sentiment] = parseInt(row.count);
            });

            return stats;
        } catch (error) {
            logger.error(`[VibesService] Error fetching community vibes: ${error.message}`);
            throw error;
        }
    }
}

module.exports = new VibesService();

