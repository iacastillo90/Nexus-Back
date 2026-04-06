const bcrypt = require('bcrypt');
const userRepository = require('../repositories/userRepository');
const roleRepository = require('../repositories/roleRepository');
const logger = require('../../utils/logger');
const { ConflictError, NotFoundError } = require('../../utils/errors');
const jwt = require('jsonwebtoken');
const { config } = require('../../config');

const SALT_ROUNDS = 10;

/**
 * @fileoverview Servicio para la lógica de negocio de Usuarios.
 * @module services/userService
 */

/**
 * Registra un nuevo usuario en el sistema.
 *
 * 1. Valida que email/username no existan.
 * 2. Hashea la contraseña.
 * 3. Busca el rol por defecto ('user').
 * 4. Crea el usuario en la BD.
 *
 * @param {Object} userData - Datos del usuario desde el controlador.
 * @param {string} userData.email
 * @param {string} userData.username
 * @param {string} userData.password - Contraseña en texto plano.
 * @param {string} [userData.firstName]
 * @param {string} [userData.lastName]
 * @returns {Promise<Object>} El nuevo usuario (sin datos sensibles).
 * @throws {ConflictError} Si el email o username ya están en uso.
 * @throws {NotFoundError} Si el rol 'user' por defecto no se encuentra.
 * @throws {Error} Si hay un error de base de datos.
 */
async function registerUser({ email, username, password, firstName, lastName }) {
    try {
        logger.info(`[UserService] Registrando nuevo usuario: ${username} `);

        // 1. Validar existencia
        const existingUser = await userRepository.findByEmailOrUsername({ email, username, });
        if (existingUser) {
            const field = existingUser.email === email ? 'Email' : 'Username';
            throw new ConflictError(`${field} esta en uso.`);
        }

        // 2. Hashear contraseña
        const passwordHash = await bcrypt.hash(password, SALT_ROUNDS);
        logger.debug(`[UserService] contraseña hasheada para usuario: ${username} `);

        // 3. Buscar rol por defecto
        const defaultRole = await roleRepository.findByName('user');
        if (!defaultRole) {
            throw new NotFoundError("Rol por defecto 'user' no encontrado.");
        }

        // 4. Crear usuario
        const newUser = await userRepository.createUser({
            email,
            username,
            passwordHash,
            roleId: defaultRole.id,
            firstName: firstName || null,
            lastName: lastName || null,
        });

        // 5. Retornar DTO (Data Transfer Object)
        return newUser.toJSON();
    } catch (error) {
        logger.error(`[UserService] Error registering user: ${error.message}`);
        throw error;
    }
}

/**
 * Elimina un usuario por su ID.
 * @param {string} userId - ID del usuario a eliminar.
 * @returns {Promise<number>} Número de filas eliminadas.
 */
async function deleteUser(userId) {
    try {
        logger.info(`[UserService] Eliminando usuario con ID: ${userId} `);
        return await userRepository.deleteUser(userId);
    } catch (error) {
        logger.error(`[UserService] Error deleting user: ${error.message}`);
        throw error;
    }
}

/**
 * Obtiene un usuario por su ID.
 * @param {string} userId - ID del usuario.
 * @returns {Promise<Object>} El usuario encontrado.
 * @throws {NotFoundError} Si el usuario no existe.
 */
async function getUserById(userId) {
    try {
        const user = await userRepository.findById(userId);
        if (!user) {
            throw new NotFoundError('Usuario no encontrado.');
        }
        return user.toJSON();
    } catch (error) {
        logger.error(`[UserService] Error getting user by ID: ${error.message}`);
        throw error;
    }
}

/**
 * Actualiza un usuario.
 * @param {string} userId - ID del usuario.
 * @param {Object} updateData - Datos a actualizar.
 * @returns {Promise<Object>} El usuario actualizado.
 * @throws {NotFoundError} Si el usuario no existe.
 * @throws {ConflictError} Si el email o username ya están en uso.
 */
async function updateUser(userId, updateData) {
    try {
        logger.info(`[UserService] Actualizando usuario con ID: ${userId}`);

        // Si se intenta actualizar password, hashearla
        if (updateData.password) {
            updateData.passwordHash = await bcrypt.hash(updateData.password, SALT_ROUNDS);
            delete updateData.password;
        }

        // Verificar si el usuario existe
        const user = await userRepository.findById(userId);
        if (!user) {
            throw new NotFoundError('Usuario no encontrado.');
        }

        // Verificar unicidad de email/username si se actualizan
        if (updateData.email || updateData.username) {
            const existingUser = await userRepository.findByEmailOrUsername({
                email: updateData.email,
                username: updateData.username
            });

            // Si existe y no es el mismo usuario
            if (existingUser && existingUser.id !== parseInt(userId)) {
                throw new ConflictError('Email o Username ya están en uso.');
            }
        }

        await userRepository.update(userId, updateData);
        return await getUserById(userId);
    } catch (error) {
        logger.error(`[UserService] Error updating user: ${error.message}`);
        throw error;
    }
}

/**
 * Autentica un usuario y genera un token JWT.
 * @param {Object} credentials - Credenciales del usuario.
 * @param {string} credentials.email
 * @param {string} credentials.password
 * @returns {Promise<Object>} Objeto con el token y datos del usuario.
 * @throws {NotFoundError} Si el usuario no existe.
 * @throws {Error} Si la contraseña es incorrecta (se lanza como Error genérico para seguridad).
 */
async function loginUser({ email, password }) {
    try {
        logger.info(`[UserService] Intentando login para: ${email}`);

        // 1. Buscar usuario por email (incluye asociación con Role)
        const user = await userRepository.findByEmailOrUsername({ email });
        if (!user) {
            throw new NotFoundError('Credenciales inválidas.');
        }

        // 2. Verificar contraseña
        const isPasswordValid = await bcrypt.compare(password, user.passwordHash);
        if (!isPasswordValid) {
            throw new Error('Credenciales inválidas.');
        }

        // 3. Generar Token JWT con el nombre del rol
        const token = jwt.sign(
            {
                id: user.id,
                role: user.role?.name || 'user' // Usar nombre del rol en lugar de UUID
            },
            config.jwt.secret,
            { expiresIn: config.jwt.expiresIn }
        );

        // 4. Retornar usuario (sin password) y token
        const userJson = user.toJSON();
        delete userJson.passwordHash;

        return {
            user: userJson,
            token,
        };
    } catch (error) {
        logger.error(`[UserService] Error en login: ${error.message}`);
        throw error;
    }
}

module.exports = {
    registerUser,
    deleteUser,
    getUserById,
    updateUser,
    loginUser,
};
