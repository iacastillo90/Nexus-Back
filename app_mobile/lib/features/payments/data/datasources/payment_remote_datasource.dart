import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../core/services/logger_service.dart';

class PaymentRemoteDataSource {
  final Dio dio;

  PaymentRemoteDataSource(this.dio);

  /// Inicializa Stripe y RevenueCat
  Future<void> initPayments() async {
    // Configura Stripe (idealmente toma la clave pública del .env)
    Stripe.publishableKey = 'pk_test_YOUR_STRIPE_PUBLISHABLE_KEY';
    await Stripe.instance.applySettings();

    // Configura RevenueCat (Google Play / App Store)
    await Purchases.setLogLevel(LogLevel.debug);
    // await Purchases.configure(PurchasesConfiguration('goog_YOUR_PUBLIC_KEY'));
  }

  /// Crea un Payment Intent en el Backend y abre la hoja de pago de Stripe
  Future<bool> checkoutWithStripe(double amount, String currency) async {
    try {
      // 1. Obtener Client Secret del Backend
      final response = await dio.post('/payments/stripe/intent', data: {
        'amount': (amount * 100).toInt(), // Cents
        'currency': currency,
      });

      final clientSecret = response.data['clientSecret'];

      // 2. Inicializar Payment Sheet de Stripe
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Nexus Digital',
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xFF00FFCC), // nexusBlue
            ),
          ),
        ),
      );

      // 3. Mostrar Payment Sheet
      await Stripe.instance.presentPaymentSheet();
      return true; // Éxito
    } on StripeException catch (e) {
      LoggerService.e('Stripe Error: ${e.error.localizedMessage}');
      return false;
    } catch (e) {
      LoggerService.e('Payment Error: $e');
      throw _handleDioError(e);
    }
  }

  /// Realiza una suscripción usando RevenueCat
  Future<bool> purchaseSubscription(Package package) async {
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      if (customerInfo.entitlements.all["premium"]?.isActive == true) {
        return true;
      }
      return false;
    } catch (e) {
      LoggerService.e('RevenueCat Error: $e');
      return false;
    }
  }

  Exception _handleDioError(dynamic error) {
    if (error is DioException && error.response != null) {
      return Exception('Payment Failed: ${error.response!.data['message']}');
    }
    return Exception('Connection error');
  }
}
