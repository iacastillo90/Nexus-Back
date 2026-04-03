const { Dream, DreamContribution, User } = require('../../models');
const aiFactory = require('./ai/ai.factory');
const logger = require('../../utils/logger');
const { NotFoundError, ValidationError } = require('../../utils/errors');

/**
 * Servicio para la gestión de Sueños Colectivos.
 */
class DreamService {
    /**
     * Crea un nuevo sueño colectivo.
     * @param {string} userId - ID del creador
     * @param {string} title - Título del sueño
     * @param {string} theme - Tema o prompt inicial
     * @returns {Promise<Object>} Dream creado
     */
    async createDream(userId, title, theme) {
        try {
            if (!title || !theme) {
                throw new ValidationError('Title and theme are required');
            }

            logger.info(`[DreamService] Creating dream "${title}" for user ${userId}`);

            // Initial AI generation for the starting state
            const aiProvider = aiFactory.getProvider();
            let initialState = { text: 'The dream begins...' };

            try {
                const prompt = `Start a collaborative dream narrative based on this theme: "${theme}". Keep it open-ended and engaging.`;
                const aiResponse = await aiProvider.generateText(prompt);
                // Try to parse if JSON, otherwise treat as string
                try {
                    initialState = JSON.parse(aiResponse);
                } catch (e) {
                    initialState = { text: aiResponse };
                }
            } catch (error) {
                logger.error(`[DreamService] Error generating initial dream state: ${error.message}`);
                // Continue with default state if AI fails
            }

            const dream = await Dream.create({
                createdBy: userId,
                title,
                theme,
                currentState: initialState,
                status: 'ACTIVE'
            });

            return dream;
        } catch (error) {
            logger.error(`[DreamService] Error creating dream: ${error.message}`);
            throw error;
        }
    }

    /**
     * Agrega una contribución de usuario y evoluciona el sueño.
     * @param {string} dreamId - ID del sueño
     * @param {string} userId - ID del contribuyente
     * @param {string} content - Contenido de la contribución
     * @returns {Promise<Object>} Contribución creada
     */
    async addContribution(dreamId, userId, content) {
        try {
            const dream = await Dream.findByPk(dreamId);
            if (!dream) {
                throw new NotFoundError('Dream not found');
            }

            if (dream.status !== 'ACTIVE') {
                throw new ValidationError('Dream is not active');
            }

            const contribution = await DreamContribution.create({
                dreamId,
                userId,
                content
            });

            // Trigger evolution (Fire & Forget or Await depending on UX)
            // For now, we await to ensure consistency for the demo
            await this.evolveDream(dream);

            return contribution;
        } catch (error) {
            logger.error(`[DreamService] Error adding contribution: ${error.message}`);
            throw error;
        }
    }

    /**
     * Evoluciona el estado del sueño basado en contribuciones recientes.
     * @param {Object} dream - Instancia del modelo Dream
     */
    async evolveDream(dream) {
        try {
            // Get recent contributions (e.g., last 5 not yet summarized)
            // For simplicity, we just get the last 5
            const contributions = await DreamContribution.findAll({
                where: { dreamId: dream.id },
                order: [['createdAt', 'DESC']],
                limit: 5,
                include: [{ model: User, as: 'contributor', attributes: ['username'] }]
            });

            const recentInputs = contributions.map(c => `${c.contributor.username}: ${c.content}`).join('\n');
            const currentNarrative = dream.currentState.text || '';

            const prompt = `
                Current Dream Narrative:
                "${currentNarrative}"

                New User Contributions:
                ${recentInputs}

                Task: Evolve the dream narrative by integrating these new contributions. 
                Keep the tone consistent with the theme "${dream.theme}".
                Provide the updated narrative segment.
            `;

            const aiProvider = aiFactory.getProvider();
            const newNarrativeSegment = await aiProvider.generateText(prompt);

            // Update state (append or replace depending on logic, here we append/update)
            const updatedState = {
                text: newNarrativeSegment, // In a real app, might want to append or keep history
                lastUpdate: new Date()
            };

            await dream.update({ currentState: updatedState });

            // Emit socket event
            try {
                const { getIO } = require('../../config/socket');
                const io = getIO();
                io.to(`dream:${dream.id}`).emit('dream:updated', {
                    dreamId: dream.id,
                    newState: updatedState
                });
            } catch (e) {
                logger.debug(`[DreamService] Socket emit failed: ${e.message}`);
            }

        } catch (error) {
            logger.error(`[DreamService] Error evolving dream ${dream.id}: ${error.message}`);
        }
    }

    /**
     * Obtiene un sueño por ID.
     */
    async getDream(dreamId) {
        try {
            const dream = await Dream.findByPk(dreamId, {
                include: [
                    { model: User, as: 'creator', attributes: ['id', 'username'] },
                    {
                        model: DreamContribution,
                        as: 'contributions',
                        limit: 20,
                        order: [['createdAt', 'DESC']],
                        include: [{ model: User, as: 'contributor', attributes: ['username'] }]
                    }
                ]
            });

            if (!dream) {
                throw new NotFoundError('Dream not found');
            }

            return dream;
        } catch (error) {
            logger.error(`[DreamService] Error fetching dream: ${error.message}`);
            throw error;
        }
    }
}

module.exports = new DreamService();

