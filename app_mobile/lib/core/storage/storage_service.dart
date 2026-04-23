import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🔐 **Servicio de Almacenamiento Seguro**
///
/// Gestiona la persistencia de datos sensibles (Tokens, Credenciales) en el dispositivo.
/// Utiliza el Keychain (iOS) y Keystore (Android) para máxima seguridad.
///
/// **Responsabilidades:**
/// - Guardar y recuperar el Token JWT.
/// - Limpiar credenciales al cerrar sesión.
/// - Proveer almacenamiento genérico clave-valor encriptado.
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

/// 🔐 **Clase StorageService**
class StorageService {
  final _storage = const FlutterSecureStorage();
  
  static const String _tokenKey = 'auth_token';
  
  /// 💾 **Guardar Token JWT**
  ///
  /// Persiste el token de sesión de forma segura.
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }
  
  /// 🔓 **Recuperar Token JWT**
  ///
  /// Retorna el token actual si existe, o `null` si no hay sesión.
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }
  
  /// 🗑️ **Eliminar Token**
  ///
  /// Borra el token de sesión. Usar al hacer Logout.
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
  
  /// 💾 **Guardar Dato Genérico**
  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  
  /// 🔓 **Leer Dato Genérico**
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }
  
  /// 🗑️ **Eliminar Dato Genérico**
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
  
  /// 🧹 **Borrar Todo**
  ///
  /// Limpia completamente el almacenamiento seguro del app.
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
