// src/routes/user.routes.js
const express = require('express');
const userController = require('./user.controller');
const validate = require('../../middleware/validator');
const { createUserSchema } = require('../../middleware/validators/user.validator');

const router = express.Router();

/**
 * @route POST /api/v1/users
 * @desc Registra un nuevo usuario.
 * @access Public
 */
const { authenticate } = require('../../middleware/auth');

router.post(
    '/',
    validate(createUserSchema), // 1. Valida el body
    userController.createUser     // 2. Llama al controlador
);

router.get('/:userId', authenticate, userController.getUserById);
router.put('/:userId', authenticate, userController.updateUser);
router.delete('/:userId', authenticate, userController.deleteUser);

module.exports = router;

