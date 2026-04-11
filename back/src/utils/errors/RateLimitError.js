/**
 * Error para límite de tasa excedido (Rate Limit).
 * @extends Error
 */
class RateLimitError extends Error {
    constructor(message) {
        super(message);
        this.name = 'RateLimitError';
        this.statusCode = 429;
    }
}

module.exports = RateLimitError;

