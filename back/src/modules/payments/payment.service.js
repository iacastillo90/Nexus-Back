const { config } = require('../../config');
const stripe = require('stripe')(config.payments.stripeSecret);
const paypal = require('@paypal/checkout-server-sdk');
const logger = require('../../utils/logger');
const { User } = require('../../models');

// Config PayPal Environment
function environment() {
    let clientId = config.payments.paypalClientId;
    let clientSecret = config.payments.paypalClientSecret;
    // For production, use LiveEnvironment instead of SandboxEnvironment
    if (config.isDevelopment) {
        return new paypal.core.SandboxEnvironment(clientId, clientSecret);
    } else {
        return new paypal.core.LiveEnvironment(clientId, clientSecret);
    }
}
function client() {
    return new paypal.core.PayPalHttpClient(environment());
}

class PaymentService {
    
    /**
     * Create a Stripe Payment Intent (for Credit Card Checkouts)
     */
    async createStripePaymentIntent(userId, amount, currency = 'usd') {
        try {
            const paymentIntent = await stripe.paymentIntents.create({
                amount: amount, // e.g., 1099 for $10.99
                currency: currency,
                metadata: { userId: userId }
            });
            return paymentIntent.client_secret;
        } catch (error) {
            logger.error(`Stripe Error: ${error.message}`);
            throw error;
        }
    }

    /**
     * Create a PayPal Order
     */
    async createPayPalOrder(userId, amount, currency = 'USD') {
        let request = new paypal.orders.OrdersCreateRequest();
        request.prefer("return=representation");
        request.requestBody({
            intent: 'CAPTURE',
            purchase_units: [{
                amount: {
                    currency_code: currency,
                    value: (amount / 100).toFixed(2) // amount in cents
                },
                custom_id: userId
            }]
        });

        try {
            let order = await client().execute(request);
            return order.result.id;
        } catch (error) {
            logger.error(`PayPal Error: ${error.message}`);
            throw error;
        }
    }

    /**
     * Capture PayPal Order
     */
    async capturePayPalOrder(orderId) {
        let request = new paypal.orders.OrdersCaptureRequest(orderId);
        request.requestBody({});
        try {
            let capture = await client().execute(request);
            return capture.result;
        } catch (error) {
            logger.error(`PayPal Capture Error: ${error.message}`);
            throw error;
        }
    }

    /**
     * Handle RevenueCat Webhooks (Google Play / App Store Subscriptions)
     */
    async handleRevenueCatWebhook(webhookData) {
        const { event } = webhookData;
        const appUserId = event.app_user_id; // Nexus user ID
        const eventType = event.type; // INITIAL_PURCHASE, RENEWAL, CANCELLATION...

        try {
            const user = await User.findByPk(appUserId);
            if (!user) {
                logger.warn(`RevenueCat: User ${appUserId} not found`);
                return;
            }

            if (eventType === 'INITIAL_PURCHASE' || eventType === 'RENEWAL') {
                user.isPremium = true;
                await user.save();
                logger.info(`User ${appUserId} subscription updated to premium.`);
            } else if (eventType === 'CANCELLATION' || eventType === 'EXPIRATION') {
                user.isPremium = false;
                await user.save();
                logger.info(`User ${appUserId} subscription cancelled/expired.`);
            }
        } catch (error) {
            logger.error(`RevenueCat Webhook Error: ${error.message}`);
            throw error;
        }
    }
}

module.exports = new PaymentService();
