const paymentsService = require('./payments.service');
const { z } = require('zod');
const logger = require('../../utils/logger');

class PaymentsController {
  
  /**
   * Generates a Stripe PaymentIntent client_secret
   */
  async createPaymentIntent(req, res) {
    try {
      const schema = z.object({
        amount: z.number().int().min(50), // Min 50 cents
        currency: z.string().default('usd'),
        metadata: z.object({}).passthrough().optional()
      });

      const { amount, currency, metadata } = schema.parse(req.body);
      const userId = req.user.id; 

      const { clientSecret, id } = await paymentsService.createPaymentIntent(amount, currency, userId, metadata);

      res.status(200).json({
        success: true,
        data: {
          clientSecret,
          paymentIntentId: id
        }
      });
    } catch (error) {
      logger.error(`[PaymentsController] Error: ${error.message}`);
      res.status(400).json({ success: false, error: error.message });
    }
  }

  /**
   * Endpoint for RevenueCat Webhooks
   */
  async revenueCatWebhook(req, res) {
    try {
      // Typically RevenueCat webhooks include an authorization header you should verify
      // const authHeader = req.headers.authorization;
      // if (authHeader !== `Bearer ${env.REVENUECAT_WEBHOOK_SECRET}`) throw new Error("Unauthorized");

      const event = req.body.event;
      if (!event) return res.status(400).json({ error: 'Missing event body' });

      await paymentsService.processRevenueCatWebhook(event);

      res.status(200).send('OK');
    } catch (error) {
      logger.error(`[PaymentsController] Webhook Error: ${error.message}`);
      res.status(400).send(`Webhook Error: ${error.message}`);
    }
  }
}

module.exports = new PaymentsController();
