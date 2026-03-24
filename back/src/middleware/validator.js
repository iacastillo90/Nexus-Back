// src/middleware/validator.js
const { ZodError } = require('zod');
const logger = require('../utils/logger');
const { ValidationError } = require('../utils/errors/ValidationError');

/**
 * Middleware para validar el request contra un esquema Zod.
 *
 * @param {import('zod').ZodSchema} schema - El esquema Zod a validar.
 * @returns {Function} Express middleware.
 */
const validate = (schema) => (req, res, next) => {
    try {
        // Validamos req.body, req.params, y req.query
        schema.parse({
            body: req.body,
            query: req.query,
            params: req.params,
        });
        next();
    } catch (error) {
        if (error instanceof ZodError) {
            const issues = error.errors || error.issues || [];
            const firstMessage = issues.length > 0 ? issues[0].message : 'Validation error';
            logger.error(`[Validator] Error validating request: ${firstMessage}`);

            // Mapeamos los errores de Zod a nuestro formato de error
            const validationErrors = new ValidationError(
                'Error de validación en la solicitud.',
                issues.map((e) => ({ field: e.path.join('.'), message: e.message }))
            );
            next(validationErrors); // Pasa al errorHandler global
        } else {
            next(error);
        }
    }
};

module.exports = validate;
