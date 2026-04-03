const { Post, User, Comment, Like } = require('../../models');
const vibesService = require('./vibes.service');
const cacheService = require('../../services/cache.service');
const logger = require('../../utils/logger');
const { Op } = require('sequelize');

class FeedService {
    /**
     * Generates a personalized Neuro-Feed for the user.
     * Algorithm: Score = (VibeMatch * 0.4) + (Engagement * 0.3) + (Recency * 0.3)
     * @param {string} userId 
     * @param {number} page 
     * @param {number} limit 
     */
    async getNeuroFeed(userId, page = 1, limit = 20) {
        const cacheKey = `feed:neuro:${userId}:p${page}:l${limit}`;
        
        try {
            const cachedFeed = await cacheService.get(cacheKey);
            if (cachedFeed) {
                logger.info(`[FeedService] Returning cached feed for user ${userId} page ${page}`);
                return cachedFeed;
            }

            // 1. Get User's Vibe
            const userVibes = await vibesService.getUserVibes(userId);
            const userCurrentSentiment = this._determineDominantSentiment(userVibes);

            // 2. Fetch Candidate Posts (Recent posts from last 24h for now)
            // In a real app, this would be a mix of following + trending
            const candidates = await Post.findAll({
                where: {
                    createdAt: {
                        [Op.gte]: new Date(Date.now() - 24 * 60 * 60 * 1000) // Last 24h
                    },
                    visibility: 'PUBLIC'
                },
                include: [
                    { model: User, as: 'author', attributes: ['id', 'username'] },
                    { model: Comment, as: 'comments', attributes: ['id'] },
                    { model: Like, as: 'likes', attributes: ['id'] }
                ],
                limit: 100 // Fetch pool of candidates
            });

            // 3. Score Candidates
            const scoredPosts = candidates.map(post => {
                const score = this._calculateNeuroScore(post, userCurrentSentiment);
                return { post, score };
            });

            // 4. Sort by Score DESC
            scoredPosts.sort((a, b) => b.score - a.score);

            // 5. Paginate
            const offset = (page - 1) * limit;
            const paginated = scoredPosts.slice(offset, offset + limit).map(item => {
                const p = item.post.toJSON();
                p.neuroScore = item.score; // Attach score for debugging/client info
                return p;
            });

            // Set Cache for 5 minutes
            await cacheService.set(cacheKey, paginated, 300);

            return paginated;

        } catch (error) {
            logger.error(`[FeedService] Error generating neuro feed: ${error.message}`);
            throw error;
        }
    }

    _determineDominantSentiment(vibesStats) {
        // Simple logic: return sentiment with highest count in distribution
        const dist = vibesStats.sentimentDistribution;
        if (dist.positive >= dist.neutral && dist.positive >= dist.negative) return 'positive';
        if (dist.negative >= dist.positive && dist.negative >= dist.neutral) return 'negative';
        return 'neutral';
    }

    _calculateNeuroScore(post, userSentiment) {
        // 1. Vibe Match (0-100)
        let vibeMatch = 50;
        if (post.sentiment === userSentiment) {
            vibeMatch = 100;
        } else if (userSentiment === 'negative' && post.sentiment === 'positive') {
            vibeMatch = 80; // Empathy/Cheer up logic
        }

        // 2. Engagement (0-100)
        const likeCount = post.likes ? post.likes.length : 0;
        const commentCount = post.comments ? post.comments.length : 0;
        const rawEngagement = likeCount + (commentCount * 2);
        const engagementScore = Math.min(100, (rawEngagement / 20) * 100); // Normalize: 20 interactions = 100

        // 3. Recency (0-100)
        const hoursSinceCreation = (Date.now() - new Date(post.createdAt).getTime()) / (1000 * 60 * 60);
        const recencyScore = 100 * Math.exp(-0.1 * hoursSinceCreation);

        // Weighted Sum
        // Score = (VibeMatch * 0.4) + (Engagement * 0.3) + (Recency * 0.3)
        return (vibeMatch * 0.4) + (engagementScore * 0.3) + (recencyScore * 0.3);
    }
}

module.exports = new FeedService();

