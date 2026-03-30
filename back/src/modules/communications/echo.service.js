const AIFactory = require('../../services/ai/ai.factory');
const vectorService = require('../../services/ai/vector.service');
const { Post, Comment } = require('../../models');
const logger = require('../../utils/logger');
const { ValidationError, ExternalAPIError } = require('../../utils/errors');

class EchoService {
    static async predictPostReaction(userId, content, options = {}) {
        if (!userId || !content) {
            throw new ValidationError('userId and content are required');
        }

        try {
            const provider = AIFactory.getProvider();
            const draftVector = await provider.generateEmbedding(content);

            const similarPosts = await vectorService.searchByUser(draftVector, userId, 3);
            let similarPostsContext = "No historical data available yet.";
            
            if (similarPosts.length > 0) {
                similarPostsContext = similarPosts.map(p => `- "${p.metadata.content}" (Likes: ${p.metadata.likes || 0})`).join('\n');
            }

            const systemPrompt = `You are an expert social media analyst. Predict the engagement for a new post based on the content and historical performance. Return a JSON object with: estimatedLikes (number), estimatedComments (number), sentiment (positive/neutral/negative), advice (string).`;
            const userPrompt = `Draft Content: "${content}"\n\nContext:\n${similarPostsContext}`;

            const responseText = await provider.generateText(systemPrompt, userPrompt);
            const cleanJson = responseText.replace(/```json/g, '').replace(/```/g, '').trim();
            const prediction = JSON.parse(cleanJson);

            return {
                ...prediction,
                confidence: 0.90
            };
        } catch (error) {
            logger.error(`[EchoService] Prediction failed: ${error.message}`);
            throw new ExternalAPIError('Failed to generate prediction');
        }
    }

    static async generateAutoReply(userId, senderId, messageContent, options = {}) {
        try {
            const provider = AIFactory.getProvider();
            
            // Search vector memory for past context between these users or general vibe
            const messageVector = await provider.generateEmbedding(messageContent);
            const memories = await vectorService.searchByUser(messageVector, userId, 5);
            const memoryContext = memories.map(m => `- ${m.metadata.text}`).join('\n');

            const systemPrompt = `You are a digital twin of the user. Reply to the message in their style using their memories as context. Keep it short and professional. Mark it as AI generated.\n\nMemories:\n${memoryContext}`;

            const reply = await provider.generateText(systemPrompt, messageContent);

            return {
                reply,
                confidence: 0.9,
                isAI: true
            };
        } catch (error) {
            logger.error(`[EchoService] Auto-reply failed: ${error.message}`);
            throw new ExternalAPIError('Failed to generate auto-reply');
        }
    }

    static async summarizeThread(postId, userId, options = {}) {
        try {
            const provider = AIFactory.getProvider();

            // REAL: Use actual comments instead of MOCK
            const commentsDB = await Comment.findAll({ where: { postId }, limit: 50 });
            if (!commentsDB || commentsDB.length === 0) {
                return { summary: "No comments yet.", keyPoints: [], sentiment: "neutral" };
            }

            const commentsText = commentsDB.map(c => c.content).join("\n");
            const systemPrompt = `Summarize the following comments thread. Identify key points and sentiment. Return a JSON object with: summary (string), keyPoints (array of strings), sentiment (positive/neutral/negative/mixed).`;

            const responseText = await provider.generateText(systemPrompt, commentsText);
            const cleanJson = responseText.replace(/```json/g, '').replace(/```/g, '').trim();
            return JSON.parse(cleanJson);
        } catch (error) {
            logger.error(`[EchoService] Summary failed: ${error.message}`);
            throw new ExternalAPIError('Failed to generate summary');
        }
    }
}

module.exports = EchoService;
