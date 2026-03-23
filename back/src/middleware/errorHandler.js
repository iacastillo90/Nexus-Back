const logger = require('../utils/logger');
const { ValidationError, ConflictError, NotFoundError, ExternalAPIError } = require('../utils/errors');

/**
 * Middleware global para manejo de errores.
 * Captura cualquier error lanzado por los controladores o middlewares anteriores.
 *
 * @param {Error} err - El error capturado.
 * @param {import('express').Request} req - La petición.
 * @param {import('express').Response} res - La respuesta.
 * @param {import('express').NextFunction} next - Función next (necesaria para que Express lo reconozca como error handler).
 */
function errorHandler(err, req, res, next) {
    // Loggear el error con stack trace si es severo
    if (err.statusCode >= 500 || !err.statusCode) {
        logger.error(`[ErrorHandler] ${err.message}\nStack: ${err.stack}`);
    } else {
        logger.warn(`[ErrorHandler] ${err.message}`);
    }

    // Determinar el código de estado
    const statusCode = err.statusCode || 500;

    // Determinar el mensaje de respuesta
    // En producción, no queremos revelar detalles de errores internos (500)
    const message =
        statusCode === 500 && process.env.NODE_ENV === 'production'
            ? 'Error interno del servidor.'
            : err.message;

    res.status(statusCode).json({
        error: err.name || 'Error',
        message: message,
        // En desarrollo, podemos enviar más detalles
        ...(process.env.NODE_ENV !== 'production' && { stack: err.stack }),
    });
}

module.exports = { errorHandler };

