/**
 * @fileoverview Índice de errores personalizados.
 * @module utils/errors
 */

const ConflictError = require('./ConflictError');
const NotFoundError = require('./NotFoundError');
const ValidationError = require('./ValidationError');
const ExternalAPIError = require('./ExternalAPIError');
const RateLimitError = require('./RateLimitError');

module.exports = {
    ConflictError,
    NotFoundError,
    ValidationError,
    ExternalAPIError,
    RateLimitError
};

