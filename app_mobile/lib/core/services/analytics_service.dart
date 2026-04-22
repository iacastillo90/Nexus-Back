import 'package:nexus_mobile/core/services/logger_service.dart';

/// Service for tracking user analytics
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();

  factory AnalyticsService() {
    return _instance;
  }

  AnalyticsService._internal();

  /// Log a custom event
  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    LoggerService.i('Analytics Event: $name, Params: $parameters');
    // TODO: Integrate with Firebase Analytics or Mixpanel
  }

  /// Set user properties
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    LoggerService.i('Analytics User Property: $name = $value');
  }

  /// Log screen view
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    LoggerService.i('Analytics Screen View: $screenName');
  }

  /// Log login
  Future<void> logLogin({
    required String method,
  }) async {
    await logEvent(
      name: 'login',
      parameters: {'method': method},
    );
  }

  /// Log sign up
  Future<void> logSignUp({
    required String method,
  }) async {
    await logEvent(
      name: 'sign_up',
      parameters: {'method': method},
    );
  }
}
