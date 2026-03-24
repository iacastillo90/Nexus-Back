// src/middleware/validators/user.validator.js
const { z } = require('zod');

/**
 * @fileoverview Esquemas de validación Zod para la entidad User.
 * @module middleware/validators/userValidator
 */

/**
 * Esquema para la creación de un nuevo usuario.
 */
const createUserSchema = z.object({
    body: z.object({
        username: z
        .string()
        .min(3, { message: "El nombre de usuario debe tener al menos 3 caracteres." })
        .max(30, { message: "El nombre de usuario no puede exceder 30 caracteres." }),
        email: z.string().email({ message: "El correo electrónica debe ser válido." }),
        password: z
        .string()
        .min(6, { message: "La contraseña debe tener al menos 6 caracteres." })
        .max(30, { message: "La contraseña no puede exceder 30 caracteres." }),
        firstName: z.string().max(50, { message: "El nombre no puede exceder 50 caracteres." }).optional(),
        lastName: z.string().max(50, { message: "El apellido no puede exceder 50 caracteres." }).optional(),
    }),
});

module.exports = {
    createUserSchema,
    // Aquí añadiremos updateUserSchema...
};
