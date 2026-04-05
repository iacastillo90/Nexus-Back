const Stripe = require('stripe');
const { env } = require('../../config/env.config');
const logger = require('../../utils/logger');

class PaymentsService {
  constructor() {
    this.stripe = new Stripe(env.STRIPE_SECRET_KEY, {
      apiVersion: '2023-10-16',
    });
  }

  /**
   * Creates a Stripe PaymentIntent for direct purchases/donations
   */
  async createPaymentIntent(amount, currency = 'usd', userId, metadata = {}) {
    try {
      const paymentIntent = await this.stripe.paymentIntents.create({
        amount, // in cents
        currency,
        metadata: {
          ...metadata,
          userId: userId.toString(),
        },
      });

      return {
        clientSecret: paymentIntent.client_secret,
        id: paymentIntent.id,
      };
    } catch (error) {
      logger.error(`[PaymentsService] Error creating PaymentIntent: ${error.message}`);
      throw error;
    }
  }

  /**
   * Process RevenueCat webhook events
   */
  async processRevenueCatWebhook(eventData) {
    logger.info(`[PaymentsService] Received RevenueCat event: ${eventData.type}`);
    // Extract user/subscriber info
    const userId = eventData.app_user_id;
    
    switch (eventData.type) {
      case 'INITIAL_PURCHASE':
      case 'RENEWAL':
        // Grant Premium Tier/Karma privileges
        logger.info(`[PaymentsService] User ${userId} subscribed successfully.`);
        // await userService.updateTier(userId, 'premium');
        break;
      case 'CANCELLATION':
        logger.info(`[PaymentsService] User ${userId} cancelled subscription.`);
        // await userService.downgradeTier(userId);
        break;
      default:
        logger.info(`[PaymentsService] Unhandled RevenueCat event type: ${eventData.type}`);
    }
    
    return true;
  }
}

module.exports = new PaymentsService();
