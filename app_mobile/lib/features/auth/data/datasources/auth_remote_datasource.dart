import 'package:dio/dio.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

/// ☁️ **Fuente de Datos Remota de Autenticación**
///
/// Gestiona la comunicación HTTP con el backend para endpoints de Auth.
///
/// **Responsabilidades:**
/// - Login, Registro, Logout.
/// - Obtener perfil actual (/me).
/// - Manejo de errores HTTP (401, 404, 500).
///
/// **Referencias:**
/// - Backend: `src/routes/auth.routes.js`
class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  /// 🔑 **Iniciar Sesión**
  ///
  /// Envía credenciales para obtener tokens.
  ///
  /// **Parámetros:**
  /// - [email]: Correo del usuario.
  /// - [password]: Contraseña en texto plano (se envía por HTTPS).
  ///
  /// **Retorno:**
  /// [AuthResponseModel] con tokens y usuario.
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 📝 **Registrar Usuario**
  ///
  /// Crea una nueva cuenta en Nexus.
  Future<AuthResponseModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 👤 **Obtener Usuario Actual**
  ///
  /// Recupera los datos del usuario dueño del token actual.
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await dio.get('/auth/me');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 🚪 **Cerrar Sesión**
  ///
  /// Invalida la sesión en el servidor (blacklist de tokens).
  Future<void> logout() async {
    try {
      await dio.post('/auth/logout');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 🚨 **Manejo de Errores Dio**
  ///
  /// Transforma excepciones de red en excepciones legibles.
  Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 400:
          return Exception('Bad request: $message');
        case 401:
          return Exception('Unauthorized: $message');
        case 404:
          return Exception('Not found: $message');
        case 500:
          return Exception('Server error: $message');
        default:
          return Exception('Error $statusCode: $message');
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout');
    } else if (error.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('Unknown error occurred');
    }
  }
}
