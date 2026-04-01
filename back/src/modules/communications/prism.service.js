const AIFactory = require('./ai/ai.factory');
const vibesService = require('./vibes.service');
const { User, Post, UserInsight } = require('../../models');
const logger = require('../../utils/logger');

/**
 * Prism Service - "The Psychological Mirror"
 * 
 * Analyzes user behavior, language, and vibes to generate deep insights.
 * Helps users understand their digital self.
 * 
 * @module prism.service
 */
class PrismService {

    /**
     * Generates a new insight for a specific user.
     * 
     * @param {string} userId - User UUID
     * @returns {Promise<Object>} Created insight
     */
    async generateInsight(userId) {
        logger.info(`[PrismService] Generating insight for user ${userId}`);

        try {
            // 1. Gather Data
            const [user, vibes, recentPosts] = await Promise.all([
                User.findByPk(userId, { attributes: ['username', 'bio'] }),
                vibesService.getUserVibes(userId),
                Post.findAll({
                    where: { userId },
                    limit: 10,
                    order: [['createdAt', 'DESC']],
                    attributes: ['content', 'sentiment', 'createdAt']
                })
            ]);

            if (recentPosts.length < 3) {
                logger.info('[PrismService] Not enough data to generate insight');
                return null;
            }

            // 2. Construct Prompt
            const prompt = this.constructPrompt(user, vibes, recentPosts);

            // 3. AI Analysis
            const provider = AIFactory.getProvider();
            const response = await provider.generateText(
                'You are The Prism, an advanced AI psychology engine. Analyze the user data and provide a deep, constructive insight.',
                prompt
            );

            // 4. Parse Response (Expecting JSON or structured text, but for now simple text)
            // Ideally we ask AI for JSON. Let's assume text for MVP or try to parse if we enforced JSON.
            // Let's enforce JSON in prompt.

            let insightData;
            try {
                const jsonStr = response.replace(/```json/g, '').replace(/```/g, '').trim();
                insightData = JSON.parse(jsonStr);
            } catch (e) {
                // Fallback if AI didn't return JSON
                insightData = {
                    type: 'personality',
                    content: response,
                    confidence: 0.7
                };
            }

            // 5. Save Insight
            const insight = await UserInsight.create({
                userId,
                type: insightData.type || 'personality',
                content: insightData.content,
                confidence: insightData.confidence || 0.8,
                metadata: {
                    analyzedPostsCount: recentPosts.length,
                    vibeScore: vibes.vibeScore
                }
            });

            logger.info(`[PrismService] Insight generated: ${insight.id}`);
            return insight;

        } catch (error) {
            logger.error(`[PrismService] Failed to generate insight: ${error.message}`);
            throw error;
        }
    }

    /**
     * Constructs the analysis prompt.
     * @private
     */
    constructPrompt(user, vibes, posts) {
        const postsText = posts.map(p => `"${p.content}" (${p.sentiment})`).join('\n');

        return `
    Analyze the following user data to generate a "Prism Insight".
    
    USER PROFILE:
    - Username: ${user.username}
    - Bio: ${user.bio}
    - Vibe Score: ${vibes.vibeScore}
    - Top Emotions: ${JSON.stringify(vibes.topEmotions)}

    RECENT ACTIVITY:
    ${postsText}

    TASK:
    Generate a single, profound insight about this user. It could be about their:
    - "personality" (e.g., "You tend to be optimistic...")
    - "habit" (e.g., "You post more when you are anxious...")
    - "suggestion" (e.g., "Try connecting with...")
    
    OUTPUT FORMAT (JSON ONLY):
    {
        "type": "personality" | "habit" | "suggestion",
        "content": "The insight text (max 2 sentences, 2nd person 'You')",
        "confidence": 0.85
    }
    `;
    }

    /**
     * Retrieves recent insights for a user.
     */
    async getInsights(userId, limit = 5) {
        return await UserInsight.findAll({
            where: { userId },
            order: [['createdAt', 'DESC']],
            limit
        });
    }
}

module.exports = new PrismService();

