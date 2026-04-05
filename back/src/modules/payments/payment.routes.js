const express = require('express');
const router = express.Router();
const paymentService = require('./payment.service');
const { authenticate } = require('../../middleware/auth');
const logger = require('../../utils/logger');

// POST /api/v1/payments/stripe/intent
router.post('/stripe/intent', authenticate, async (req, res, next) => {
    try {
        const { amount, currency } = req.body;
        const clientSecret = await paymentService.createStripePaymentIntent(req.user.id, amount, currency);
        res.json({ clientSecret });
    } catch (error) {
        next(error);
    }
});

// POST /api/v1/payments/paypal/order
router.post('/paypal/order', authenticate, async (req, res, next) => {
    try {
        const { amount, currency } = req.body;
        const orderId = await paymentService.createPayPalOrder(req.user.id, amount, currency);
        res.json({ orderId });
    } catch (error) {
        next(error);
    }
});

// POST /api/v1/payments/paypal/capture
router.post('/paypal/capture', authenticate, async (req, res, next) => {
    try {
        const { orderId } = req.body;
        const capture = await paymentService.capturePayPalOrder(orderId);
        res.json({ success: true, capture });
    } catch (error) {
        next(error);
    }
});

// POST /api/v1/payments/revenuecat/webhook
// Note: No 'authenticate' middleware here because it's called by RevenueCat servers
router.post('/revenuecat/webhook', async (req, res, next) => {
    try {
        const { config } = require('../../config');
        const authHeader = req.headers.authorization;
        if (authHeader !== `Bearer ${config.payments.revenuecatAuth}`) {
            logger.warn('Unauthorized RevenueCat webhook attempt');
            return res.status(401).json({ error: 'Unauthorized' });
        }

        await paymentService.handleRevenueCatWebhook(req.body);
        res.status(200).send('OK');
    } catch (error) {
        next(error);
    }
});

module.exports = router;
