// src/utils/errors/ConflictError.js
/**
 * Error para conflictos de recursos (ej. email ya existe).
 * @extends Error
 */
class ConflicError extends Error {
    constructor(message) {
        super(message);
        this.name = 'ConflictError'
        this.statusCode = 409;
    }
}

module.exports = ConflicError;
