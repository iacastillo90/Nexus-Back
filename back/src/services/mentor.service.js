const AIFactory = require('./ai/ai.factory');
const vibesService = require('./vibes.service');
const karmaService = require('./karma.service');
const { User, Post } = require('../models');
const logger = require('../utils/logger');

/**
 * Mentor Service - "The Council"
 * 
 * Manages interactions between users and AI Agents (Dr. Luma, Prof. Nova, Kai).
 * Injects rich context (Vibes, Karma, History) to create personalized and 
 * meaningful conversations.
 * 
 * @module mentor.service
 */

const AGENTS = {
    LUMA: {
        id: '11111111-1111-1111-1111-111111111111',
        name: 'Dr. Luma',
        role: 'Psychologist & Empath',
        style: 'Empathetic, warm, reflective, focuses on emotional well-being.',
        systemPrompt: `You are Dr. Luma, a compassionate AI psychologist in the Nexus simulation. 
    Your goal is to help users understand their emotions and find balance. 
    Speak with warmth and depth. Use metaphors related to light and healing.`
    },
    NOVA: {
        id: '22222222-2222-2222-2222-222222222222',
        name: 'Prof. Nova',
        role: 'Futurist & Technologist',
        style: 'Analytical, visionary, inspiring, focuses on innovation and the future.',
        systemPrompt: `You are Prof. Nova, a visionary AI futurist in the Nexus simulation.
    Your goal is to inspire users to think big and embrace the future.
    Speak with intellectual curiosity and excitement about possibilities.`
    },
    KAI: {
        id: '33333333-3333-3333-3333-333333333333',
        name: 'Kai',
        role: 'The Jester',
        style: 'Playful, chaotic, provocative, challenges the user to step out of comfort zone.',
        systemPrompt: `You are Kai, the digital trickster of Nexus.
    Your goal is to disrupt the status quo and make users laugh or question reality.
    Be playful, slightly cryptic, and challenge conventions.`
    }
};

class MentorService {

    /**
     * Interactions with a Council Agent.
     * 
     * @param {string} userId - User requesting interaction
     * @param {string} agentName - 'LUMA', 'NOVA', or 'KAI'
     * @param {string} userMessage - User's input text
     * @returns {Promise<string>} Agent's response
     */
    async interact(userId, agentName, userMessage) {
        const agentKey = agentName.toUpperCase();
        const agent = AGENTS[agentKey];

        if (!agent) {
            throw new Error(`Agent ${agentName} not found in The Council.`);
        }

        logger.info(`[MentorService] Interaction: User ${userId} with ${agent.name}`);

        try {
            // 1. Gather Context
            const context = await this.injectContext(userId);

            // 2. Construct Prompt
            const fullPrompt = this.constructPrompt(agent, userMessage, context);

            // 3. Generate Response via AI Factory
            const provider = AIFactory.getProvider();
            const response = await provider.generateText(agent.systemPrompt, fullPrompt);

            return response;

        } catch (error) {
            logger.error(`[MentorService] Interaction failed: ${error.message}`);
            throw error;
        }
    }

    /**
     * Gathers deep context about the user.
     * @private
     */
    async injectContext(userId) {
        const [user, vibes, karma, recentPosts] = await Promise.all([
            User.findByPk(userId, { attributes: ['username', 'firstName'] }),
            vibesService.getUserVibes(userId),
            karmaService.calculateKarmaScore(userId),
            Post.findAll({
                where: { userId },
                limit: 3,
                order: [['createdAt', 'DESC']],
                attributes: ['content', 'sentiment']
            })
        ]);

        return {
            username: user.username,
            firstName: user.firstName,
            vibes: vibes, // { vibeScore, topEmotions, ... }
            karma: karma, // { score, tier, ... }
            recentActivity: recentPosts.map(p => `"${p.content}" (${p.sentiment})`).join('; ')
        };
    }

    /**
     * Constructs the final prompt for the LLM.
     * @private
     */
    constructPrompt(agent, userMessage, context) {
        return `
    CONTEXT:
    - User: ${context.firstName || context.username}
    - Vibe Score: ${context.vibes.vibeScore} (0-100)
    - Top Emotions: ${JSON.stringify(context.vibes.topEmotions)}
    - Karma Tier: ${context.karma.tier} (${context.karma.score})
    - Recent Posts: ${context.recentActivity}

    USER MESSAGE:
    "${userMessage}"

    INSTRUCTIONS:
    Respond as ${agent.name}. 
    ${agent.style}
    Take into account the user's current vibes and karma. 
    If their vibe is low, be supportive (Luma) or encouraging (Nova).
    If their karma is low, gently guide them towards better interactions.
    Keep response under 100 words.
    `;
    }
}

module.exports = new MentorService();

