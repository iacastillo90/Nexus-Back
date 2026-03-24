/**
 * @fileoverview Esquemas de validación para usuarios usando Zod.
 * @module middleware/validators/userValidator
 */

const { z } = require('zod');

/**
 * Esquema de validación para la creación de usuarios.
 * @type {import('zod').ZodObject}
 */
const createUserSchema = z.object({
    body: z.object({
        email: z.string().email('Email inválido'),
        username: z.string().min(3, 'El nombre de usuario debe tener al menos 3 caracteres'),
        password: z.string().min(6, 'La contraseña debe tener al menos 6 caracteres'),
        firstName: z.string().optional(),
        lastName: z.string().optional(),
    })
});

/**
 * Esquema de validación para el inicio de sesión.
 * @type {import('zod').ZodObject}
 */
const loginUserSchema = z.object({
    body: z.object({
        email: z.string().email('Email inválido'),
        password: z.string().min(1, 'La contraseña es requerida'),
    })
});

module.exports = {
    createUserSchema,
    loginUserSchema,
};

