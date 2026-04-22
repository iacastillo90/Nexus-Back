import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/api_constants.dart';
import '../storage/storage_service.dart';
import 'interceptors/auth_interceptor.dart';

/// 🌐 **Proveedor de Cliente HTTP (Dio)**
///
/// Configura la instancia global de Dio para realizar peticiones REST.
/// Incluye interceptores para Autenticación y Logging.
///
/// **Configuración:**
/// - Base URL: Definida en [ApiConstants].
/// - Timeouts: Connect/Receive timeouts estándar.
/// - Headers: JSON por defecto.
///
/// **Interceptores:**
/// - [AuthInterceptor]: Inyecta el token Bearer.
/// - [PrettyDioLogger]: Loguea requests/responses en consola.
final networkDioProvider = Provider<Dio>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  
  final options = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
    receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  
  final dio = Dio(options);
  
  dio.interceptors.addAll([
    AuthInterceptor(storageService),
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  ]);
  
  return dio;
});
