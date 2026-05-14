import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RevenueCatService {
  static final RevenueCatService _instance = RevenueCatService._internal();
  factory RevenueCatService() => _instance;
  RevenueCatService._internal();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.error);

      PurchasesConfiguration? configuration;

      if (Platform.isAndroid) {
        final apiKey = dotenv.env['REVENUECAT_ANDROID_KEY'];
        if (apiKey != null && apiKey.isNotEmpty) {
          configuration = PurchasesConfiguration(apiKey);
        }
      } else if (Platform.isIOS) {
        final apiKey = dotenv.env['REVENUECAT_IOS_KEY'];
        if (apiKey != null && apiKey.isNotEmpty) {
          configuration = PurchasesConfiguration(apiKey);
        }
      }

      if (configuration != null) {
        await Purchases.configure(configuration);
        _isInitialized = true;
        debugPrint('✅ RevenueCat initialized successfully');
      } else {
        debugPrint('⚠️ RevenueCat not initialized: API keys missing');
      }
    } catch (e) {
      debugPrint('❌ Error initializing RevenueCat: $e');
    }
  }

  Future<Offerings?> getOfferings() async {
    if (!_isInitialized) return null;
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('❌ Error getting offerings: $e');
      return null;
    }
  }

  Future<CustomerInfo?> purchasePackage(Package package) async {
    if (!_isInitialized) return null;
    try {
      return await Purchases.purchasePackage(package);
    } catch (e) {
      debugPrint('❌ Error purchasing package: $e');
      return null;
    }
  }

  Future<CustomerInfo?> restorePurchases() async {
    if (!_isInitialized) return null;
    try {
      return await Purchases.restorePurchases();
    } catch (e) {
      debugPrint('❌ Error restoring purchases: $e');
      return null;
    }
  }

  Future<bool> hasActiveEntitlement(String entitlementId) async {
    if (!_isInitialized) return false;
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
    } catch (e) {
      debugPrint('❌ Error checking entitlement: $e');
      return false;
    }
  }
}
