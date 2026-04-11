/**
 * Error lanzado cuando fallan las validaciones de datos.
 * @class ValidationError
 * @extends {Error}
 */
class ValidationError extends Error {
    constructor(message) {
        super(message);
        this.name = 'ValidationError';
        this.statusCode = 400;
    }
}

module.exports = ValidationError;

