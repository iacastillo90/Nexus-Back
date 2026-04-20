import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talker/talker.dart';

/// Dio client singleton for API requests
class DioClient {
  static Dio? _instance;
  static final Talker _talker = Talker();

  static Dio get instance {
    if (_instance == null) {
      _instance = Dio(
        BaseOptions(
          baseUrl: dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api/v1',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      // Add interceptors
      _instance!.interceptors.add(_createLoggingInterceptor());
      _instance!.interceptors.add(_createAuthInterceptor());
      _instance!.interceptors.add(_createErrorInterceptor());
    }
    return _instance!;
  }

  /// Logging interceptor
  static Interceptor _createLoggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        _talker.debug(
          '🌐 REQUEST[${options.method}] => ${options.uri}\n'
          'Headers: ${options.headers}\n'
          'Data: ${options.data}',
        );
        handler.next(options);
      },
      onResponse: (response, handler) {
        _talker.info(
          '✅ RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}\n'
          'Data: ${response.data}',
        );
        handler.next(response);
      },
      onError: (error, handler) {
        _talker.error(
          '❌ ERROR[${error.response?.statusCode}] => ${error.requestOptions.uri}\n'
          'Message: ${error.message}\n'
          'Data: ${error.response?.data}',
        );
        handler.next(error);
      },
    );
  }

  /// Auth interceptor (adds JWT token to requests)
  static Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Token will be added by AuthController when available
        // For now, just pass through
        handler.next(options);
      },
    );
  }

  /// Error interceptor
  static Interceptor _createErrorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        // Handle specific error codes
        if (error.response?.statusCode == 401) {
          // Token expired or invalid
          _talker.warning('🔒 Unauthorized - Token may be expired');
        } else if (error.response?.statusCode == 500) {
          _talker.error('🔥 Server error');
        }
        handler.next(error);
      },
    );
  }

  /// Add auth token to requests
  static void setAuthToken(String token) {
    _instance?.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Remove auth token
  static void clearAuthToken() {
    _instance?.options.headers.remove('Authorization');
  }
}
