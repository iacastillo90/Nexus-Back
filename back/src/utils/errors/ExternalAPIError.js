/**
 * Error lanzado cuando falla una llamada a una API externa.
 * @class ExternalAPIError
 * @extends {Error}
 */
class ExternalAPIError extends Error {
    constructor(message) {
        super(message);
        this.name = 'ExternalAPIError';
        this.statusCode = 503;
    }
}

module.exports = ExternalAPIError;

