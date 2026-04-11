// src/utils/errors/NotFoundError.js
/**
 * Error para recursos no encontrados.
 * @extends Error
 */
class NotFoundError extends Error {
  constructor(message) {
    super(message);
    this.name = 'NotFoundError';
    this.statusCode = 404;
  }
}

module.exports = NotFoundError;
