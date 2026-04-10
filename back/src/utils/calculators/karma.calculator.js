const { User, Follow, Post, sequelize } = require('../../models');
const graphService = require('../../services/graph.service');
const logger = require('../logger');

/**
 * Calcula el componente de PageRank.
 */
async function calculatePageRankComponent(userId) {
    try {
        let influentialUsers = [];
        if (graphService.getInfluentialUsers) {
            influentialUsers = await graphService.getInfluentialUsers(1000);
        }
        const userRank = influentialUsers.find(u => u.userId === userId);
        return userRank ? Math.round(userRank.influenceScore * 1000) : 100;
    } catch (error) {
        logger.warn('[KarmaCalculator] Failed to get PageRank', { userId, error: error.message });
        return 100;
    }
}

/**
 * Calcula el componente de Antigüedad de la Cuenta.
 */
async function calculateAccountAgeComponent(user) {
    const now = new Date();
    const createdAt = new Date(user.createdAt);
    const ageInDays = Math.floor((now - createdAt) / (1000 * 60 * 60 * 24));

    if (ageInDays < 1) return 0;
    if (ageInDays < 7) return 100 + ((ageInDays - 1) / 6) * 200;
    if (ageInDays < 30) return 300 + ((ageInDays - 7) / 23) * 300;
    if (ageInDays < 180) return 600 + ((ageInDays - 30) / 150) * 300;
    return 1000;
}

/**
 * Calcula el componente de Calidad de Engagement.
 */
async function calculateEngagementComponent(userId) {
    try {
        const postStats = await Post.findAll({
            where: { userId },
            attributes: [
                [sequelize.fn('COUNT', sequelize.col('id')), 'totalPosts']
            ],
            raw: true
        });
        const totalPosts = parseInt(postStats[0]?.totalPosts || 0);
        if (totalPosts === 0) return 0;

        const totalLikes = await sequelize.model('Like').count({
            include: [{ model: Post, where: { userId }, required: true }]
        });
        const totalComments = await sequelize.model('Comment').count({
            include: [{ model: Post, where: { userId }, required: true }]
        });

        const engagementRatio = Math.min((totalLikes + totalComments) / totalPosts / 10, 1);

        // Cálculo simplificado de diversidad para reducir código
        const score = Math.round(engagementRatio * 1000);
        return score;
    } catch (error) {
        return 100;
    }
}

/**
 * Calcula el componente de Confianza de la Red.
 * Nota: Recibe una función getCachedKarmaFn para evitar dependencias circulares complejas.
 */
async function calculateTrustComponent(userId, getCachedKarmaFn) {
    try {
        const followers = await Follow.findAll({
            where: { followingId: userId },
            attributes: ['followerId'],
            limit: 100
        });
        if (followers.length === 0) return 0;

        const followerKarmas = await Promise.all(
            followers.map(async (f) => {
                const k = await getCachedKarmaFn(f.followerId);
                return k?.score || 200;
            })
        );

        const avg = followerKarmas.reduce((a, b) => a + b, 0) / followerKarmas.length;
        const factor = Math.min(Math.log10(followers.length + 1) / 2, 1);
        return Math.round((avg / 1000) * factor * 1000);
    } catch (error) {
        return 100;
    }
}

module.exports = {
    calculatePageRankComponent,
    calculateAccountAgeComponent,
    calculateEngagementComponent,
    calculateTrustComponent
};

