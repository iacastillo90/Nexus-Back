const { z } = require('zod');
const { ValidationError } = require('../../utils/errors');

const predictSchema = z.object({
    content: z.string().min(1).max(5000, 'Content too long')
});

const autoReplySchema = z.object({
    senderId: z.string().uuid(),
    messageContent: z.string().min(1).max(1000)
});

/**
 * Validates incoming Echo requests based on the route path.
 * Uses Zod schemas for validation.
 * 
 * @param {import('express').Request} req - Express request object
 * @param {import('express').Response} res - Express response object
 * @param {import('express').NextFunction} next - Express next function
 */
function validateEchoRequest(req, res, next) {
    try {
        if (req.path === '/predict') {
            predictSchema.parse(req.body);
        } else if (req.path === '/auto-reply') {
            autoReplySchema.parse(req.body);
        }
        next();
    } catch (error) {
        const errorMessage = error.errors ? error.errors[0].message : 'Validation failed';
        next(new ValidationError(errorMessage));
    }
}

module.exports = { validateEchoRequest };

