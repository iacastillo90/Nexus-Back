import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 🔐 **Fuente de Datos Local de Autenticación**
///
/// Gestiona el almacenamiento seguro de credenciales en el dispositivo.
///
/// **Responsabilidades:**
/// - Guardar/Leer/Borrar Token JWT.
/// - Guardar/Leer/Borrar Refresh Token.
/// - Limpiar sesión completa.
///
/// **Dependencias:**
/// - [FlutterSecureStorage]: Para encriptación nativa (Keychain/Keystore).
class AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'cached_user';

  AuthLocalDataSource(this.secureStorage);

  /// 💾 **Guardar Token de Acceso**
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
  }

  /// 🔓 **Obtener Token de Acceso**
  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  /// 🗑️ **Borrar Token de Acceso**
  Future<void> deleteToken() async {
    await secureStorage.delete(key: _tokenKey);
  }

  /// 💾 **Guardar Refresh Token**
  Future<void> saveRefreshToken(String refreshToken) async {
    await secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  /// 🔓 **Obtener Refresh Token**
  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: _refreshTokenKey);
  }

  /// 🗑️ **Borrar Refresh Token**
  Future<void> deleteRefreshToken() async {
    await secureStorage.delete(key: _refreshTokenKey);
  }

  /// 🧹 **Limpiar Datos de Sesión**
  ///
  /// Elimina todos los tokens y datos de usuario cacheados.
  Future<void> clearAuthData() async {
    await Future.wait([
      deleteToken(),
      deleteRefreshToken(),
      secureStorage.delete(key: _userKey),
    ]);
  }
}
