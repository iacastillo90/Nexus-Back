import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripePaymentService {
  static final StripePaymentService _instance = StripePaymentService._internal();
  factory StripePaymentService() => _instance;
  StripePaymentService._internal();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      final publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'];
      if (publishableKey != null && publishableKey.isNotEmpty) {
        Stripe.publishableKey = publishableKey;
        await Stripe.instance.applySettings();
        _isInitialized = true;
        debugPrint('✅ Stripe initialized successfully');
      } else {
        debugPrint('⚠️ Stripe not initialized: Publishable key missing');
      }
    } catch (e) {
      debugPrint('❌ Error initializing Stripe: $e');
    }
  }

  Future<bool> presentPaymentSheet({
    required String clientSecret,
    required String merchantDisplayName,
  }) async {
    if (!_isInitialized) return false;
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: merchantDisplayName,
          style: ThemeMode.dark,
          // Apple/Google Pay config would go here as well if active
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),
          applePay: const PaymentSheetApplePay(
            merchantCountryCode: 'US',
          ),
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      debugPrint('✅ Payment completed successfully via PaymentSheet');
      return true;
    } on StripeException catch (e) {
      debugPrint('⚠️ Stripe Exception (could be cancelled by user): $e');
      return false;
    } catch (e) {
      debugPrint('❌ Unforeseen error presenting payment sheet: $e');
      return false;
    }
  }
}
