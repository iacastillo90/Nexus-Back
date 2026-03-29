const express = require('express');
const userController = require('../users/user.controller');
const authController = require('./auth.controller');
const validate = require('../../middleware/validator');
const { createUserSchema, loginUserSchema } = require('../../middleware/validators/user.validator');

const router = express.Router();

// Ruta para registro de usuarios
router.post(
    '/register',
    validate(createUserSchema),
    userController.createUser
);

// Ruta para login de usuarios
router.post(
    '/login',
    validate(loginUserSchema),
    userController.login
);

// Recuperación de Contraseña
router.post('/recover-password', authController.recoverPassword);
router.post('/reset-password', authController.resetPassword);

// Verificación de email
router.post('/verify-email', authController.verifyEmail);

module.exports = router;
