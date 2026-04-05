const express = require('express');
const paymentsController = require('./payments.controller');
const authMiddleware = require('../../middleware/auth');

const router = express.Router();

// Generate a Stripe PaymentIntent for the current user
router.post(
  '/stripe/payment-intent',
  authMiddleware,
  paymentsController.createPaymentIntent
);

// Webhook endpoint for RevenueCat events (Public endpoint, but secure via headers)
router.post(
  '/revenuecat/webhook',
  paymentsController.revenueCatWebhook
);

module.exports = router;
