// src/controllers/user.controller.js
const userService = require('./userService');
const logger = require('../../utils/logger');
const { ValidationError } = require('../../utils/errors');

/**
 * @fileoverview Controlador para las peticiones HTTP de Usuarios.
 * @module controllers/userController
 */

/**
 * Maneja la creación (registro) de un nuevo usuario.
 * @param {import('express').Request} req - Objeto de solicitud de Express.
 * @param {import('express').Response} res - Objeto de respuesta de Express.
 * @param {import('express').NextFunction} next - Función middleware 'next' de Express.
 */
async function createUser(req, res, next) {
    try {
        // Los datos ya fueron validados por el middleware 'validate'
        const userData = req.body;
        logger.info(`[UserController] Creando usuario: ${userData.username} `);

        const newUser = await userService.registerUser(userData);
        res.status(201).json({
            message: 'Usuario creado exitosamente.',
            user: newUser,
        });
    } catch (error) {
        // Si algo falla, lo pasamos al errorHandler global
        logger.error(`[UserController] Error al crear usuario: ${error.message} `);
        next(error);
    }
}

/**
 * Elimina un usuario por su ID.
 * @param {import('express').Request} req - Objeto de solicitud de Express.
 * @param {import('express').Response} res - Objeto de respuesta de Express.
 * @param {import('express').NextFunction} next - Función middleware 'next' de Express.
 */
async function deleteUser(req, res, next) {
    try {
        const { userId } = req.params;
        const deletedRows = await userService.deleteUser(userId);

        if (deletedRows > 0) {
            res.status(200).json({ message: 'Usuario eliminado exitosamente.' });
        } else {
            res.status(404).json({ message: 'Usuario no encontrado.' });
        }
    } catch (error) {
        if (error instanceof ValidationError) {
            res.status(400).json({ message: error.message });
        } else {
            next(error);
        }
    }
}

/**
 * Obtiene un usuario por ID.
 */
async function getUserById(req, res, next) {
    try {
        const { userId } = req.params;
        const user = await userService.getUserById(userId);

        if (!user) {
            return res.status(404).json({ message: 'Usuario no encontrado.' });
        }

        res.status(200).json(user);
    } catch (error) {
        next(error);
    }
}

/**
 * Actualiza un usuario.
 */
async function updateUser(req, res, next) {
    try {
        const { userId } = req.params;
        const updateData = req.body;

        // Verificar autorización (solo el mismo usuario o admin)
        if (req.user.id !== userId && req.user.role !== 'admin') {
            return res.status(403).json({ message: 'No autorizado para actualizar este perfil.' });
        }

        const updatedUser = await userService.updateUser(userId, updateData);

        if (!updatedUser) {
            return res.status(404).json({ message: 'Usuario no encontrado.' });
        }

        res.status(200).json(updatedUser);
    } catch (error) {
        next(error);
    }
}

/**
 * Maneja el inicio de sesión de un usuario.
 */
async function login(req, res, next) {
    try {
        const credentials = req.body;
        logger.info(`[UserController] Iniciando sesión para: ${credentials.email}`);

        const result = await userService.loginUser(credentials);
        res.status(200).json({
            message: 'Login exitoso.',
            ...result,
        });
    } catch (error) {
        logger.error(`[UserController] Error en login: ${error.message}`);
        next(error);
    }
}

module.exports = {
    createUser,
    deleteUser,
    getUserById,
    updateUser,
    login
};

