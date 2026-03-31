const { getRedisClient } = require('../../config/redis');
const logger = require('../../utils/logger');

const PRESENCE_KEY = 'presence:online';
const PRESENCE_TTL = 300; // 5 minutos

/**
 * Marca un usuario como online.
 * @param {string} userId - ID del usuario
 * @param {string} socketId - ID del socket
 */
async function setUserOnline(userId, socketId) {
    try {
        const client = await getRedisClient();

        // Guardar socket ID asociado al usuario (para manejar múltiples conexiones)
        await client.sAdd(`presence:user:${userId}:sockets`, socketId);

        // Agregar usuario al set de usuarios online
        await client.sAdd(PRESENCE_KEY, userId);

        // Emitir evento de usuario online
        const { getIO } = require('../../config/socket');
        try {
            const io = getIO();
            io.emit('user:online', { userId });
        } catch (socketError) {
            logger.debug(`[PresenceService] Could not emit online event: ${socketError.message}`);
        }

        logger.debug(`[PresenceService] User ${userId} is now online`);
    } catch (error) {
        logger.error(`[PresenceService] Error setting user online: ${error.message}`);
    }
}

/**
 * Marca un usuario como offline.
 * @param {string} userId - ID del usuario
 * @param {string} socketId - ID del socket
 */
async function setUserOffline(userId, socketId) {
    try {
        const client = await getRedisClient();

        // Remover socket ID
        await client.sRem(`presence:user:${userId}:sockets`, socketId);

        // Verificar si el usuario tiene otros sockets activos
        const activeSockets = await client.sCard(`presence:user:${userId}:sockets`);

        if (activeSockets === 0) {
            // No hay más conexiones, marcar como offline
            await client.sRem(PRESENCE_KEY, userId);

            // Limpiar set de sockets
            await client.del(`presence:user:${userId}:sockets`);

            // Emitir evento de usuario offline
            const { getIO } = require('../../config/socket');
            try {
                const io = getIO();
                io.emit('user:offline', { userId });
            } catch (socketError) {
                logger.debug(`[PresenceService] Could not emit offline event: ${socketError.message}`);
            }

            logger.debug(`[PresenceService] User ${userId} is now offline`);
        }
    } catch (error) {
        logger.error(`[PresenceService] Error setting user offline: ${error.message}`);
    }
}

/**
 * Obtiene la lista de usuarios online.
 * @returns {Promise<string[]>} Lista de IDs de usuarios online
 */
async function getOnlineUsers() {
    try {
        const client = await getRedisClient();
        return await client.sMembers(PRESENCE_KEY);
    } catch (error) {
        logger.error(`[PresenceService] Error getting online users: ${error.message}`);
        return [];
    }
}

/**
 * Verifica si un usuario está online.
 * @param {string} userId - ID del usuario
 * @returns {Promise<boolean>} True si está online
 */
async function isUserOnline(userId) {
    try {
        const client = await getRedisClient();
        return await client.sIsMember(PRESENCE_KEY, userId);
    } catch (error) {
        logger.error(`[PresenceService] Error checking user status: ${error.message}`);
        return false;
    }
}

module.exports = {
    setUserOnline,
    setUserOffline,
    getOnlineUsers,
    isUserOnline
};

