const dreamService = require('./dream.service');

/**
 * Crea un nuevo sueño.
 */
async function createDream(req, res, next) {
    try {
        const { title, theme } = req.body;
        const userId = req.user.id;

        const dream = await dreamService.createDream(userId, title, theme);

        res.status(201).json(dream);
    } catch (error) {
        next(error);
    }
}

/**
 * Agrega una contribución a un sueño.
 */
async function addContribution(req, res, next) {
    try {
        const { id } = req.params;
        const { content } = req.body;
        const userId = req.user.id;

        const contribution = await dreamService.addContribution(id, userId, content);

        res.status(201).json(contribution);
    } catch (error) {
        next(error);
    }
}

/**
 * Obtiene un sueño por ID.
 */
async function getDream(req, res, next) {
    try {
        const { id } = req.params;
        const dream = await dreamService.getDream(id);

        res.status(200).json(dream);
    } catch (error) {
        next(error);
    }
}

module.exports = {
    createDream,
    addContribution,
    getDream
};

