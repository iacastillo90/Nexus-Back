const { User } = require('../models');
const { Op } = require('sequelize');
const logger = require('../utils/logger');

/**
 * @fileoverview Repositorio para la entidad User.
 * @module repositories/userRepository
 */

/**
 * Busca un usuario por email o username.
 *
 * @param {Object} options
 * @param {string} [options.email] - Email del usuario.
 * @param {string} [options.username] - Username del usuario.
 * @returns {Promise<User|null>} El modelo del usuario o null.
 */
async function findByEmailOrUsername({ email, username }) {
    logger.debug(`[UserRepository] Buscando usuario por email: ${email} o username: ${username}`);
    try {
        const conditions = [];
        if (email) conditions.push({ email });
        if (username) conditions.push({ username });

        if (conditions.length === 0) {
            return null; // No search criteria provided
        }

        // Note: We use unscoped() to bypass the defaultScope that excludes passwordHash
        // This is necessary for authentication purposes
        // We also include the Role association to get the role name for JWT
        const { Role } = require('../models');
        const user = await User.unscoped().findOne({
            where: {
                [Op.or]: conditions
            },
            include: [{
                model: Role,
                as: 'role',
                attributes: ['id', 'name']
            }]
        });
        return user;
    } catch (error) {
        logger.error(`[UserRepository] Error al buscar usuario: ${error.message}`);
        throw error;
    }
}

/**
 * Crea un nuevo usuario en la base de datos.
 *
 * @param {Object} userData - Datos del usuario.
 * @returns {Promise<User>} El usuario recién creado.
 */
async function createUser(userData) {
    logger.debug(`[UserRepository] Creando usuario con email: ${userData.email}`);
    try {
        const newUser = await User.create(userData);
        return newUser;
    } catch (error) {
        logger.error(`[UserRepository] Error al crear usuario: ${error.message}`);
        throw error;
    }
}

/**
 * Elimina un usuario por su ID.
 * @param {string} userId - ID del usuario a eliminar.
 * @returns {Promise<number>} Número de filas eliminadas.
 */
async function deleteUser(userId) {
    logger.info(`[UserRepository] Eliminando usuario con ID: ${userId}`);
    try {
        const deletedRows = await User.destroy({
            where: { id: userId }
        });
        return deletedRows;
    } catch (error) {
        logger.error(`[UserRepository] Error al eliminar usuario: ${error.message}`);
        throw error;
    }
}

/**
 * Busca un usuario por su ID.
 * @param {string} id - ID del usuario.
 * @returns {Promise<User|null>} El usuario encontrado o null.
 */
async function findById(id) {
    logger.debug(`[UserRepository] Buscando usuario por ID: ${id}`);
    try {
        const user = await User.findByPk(id, {
            attributes: { exclude: ['passwordHash'] },
        });
        return user;
    } catch (error) {
        logger.error(`[UserRepository] Error al buscar usuario por ID: ${error.message}`);
        throw error;
    }
}

/**
 * Actualiza un usuario.
 * @param {string} id - ID del usuario.
 * @param {Object} updateData - Datos a actualizar.
 * @returns {Promise<number>} Número de filas afectadas.
 */
async function update(id, updateData) {
    logger.debug(`[UserRepository] Actualizando usuario con ID: ${id}`);
    try {
        const [updatedRows] = await User.update(updateData, {
            where: { id },
        });
        return updatedRows;
    } catch (error) {
        logger.error(`[UserRepository] Error al actualizar usuario: ${error.message}`);
        throw error;
    }
}

module.exports = {
    findByEmailOrUsername,
    createUser,
    deleteUser,
    findById,
    update,
};
