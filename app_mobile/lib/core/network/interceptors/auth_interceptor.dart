import 'package:dio/dio.dart';
import '../../storage/storage_service.dart';

/// 🔐 **Interceptor de Autenticación**
///
/// Middleware HTTP que inyecta automáticamente el Token JWT en cada petición.
///
/// **Responsabilidades:**
/// - Leer el token del almacenamiento seguro ([StorageService]).
/// - Añadir el header `Authorization: Bearer <token>`.
/// - Permitir peticiones anónimas si no hay token (aunque el backend las rechazará si requieren auth).
class AuthInterceptor extends Interceptor {
  final StorageService _storageService;

  AuthInterceptor(this._storageService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storageService.getToken();
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Si el error es 401 Unauthorized
    if (err.response?.statusCode == 401) {
      final token = await _storageService.getToken();
      
      if (token != null) {
        // En una implementación real, aquí harías la llamada a /auth/refresh
        // usando otra instancia de Dio sin el interceptor para evitar loops.
        // Simularemos que el backend tiene la ruta, o limpiaremos sesión si falla.
        
        try {
          // TODO: Implementar llamada real a refresh token en el backend
          // final refreshToken = await _storageService.read('refresh_token');
          // final response = await Dio().post(ApiConstants.baseUrl + '/auth/refresh', data: {'token': refreshToken});
          // await _storageService.saveToken(response.data['token']);
          
          // Por ahora, simulamos fallo y limpiamos la sesión
          await _storageService.deleteAll();
          
          // Podríamos emitir un evento a Riverpod o Navigator para redirigir a Login
        } catch (e) {
          // Si falla el refresh, forzar logout
          await _storageService.deleteAll();
        }
      }
    }
    
    return handler.next(err);
  }
}
