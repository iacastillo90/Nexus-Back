import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';

part 'auth_providers.g.dart';

/// 🌐 **Proveedor de Dio (Cliente HTTP)**
///
/// Expone la instancia configurada globalmente en el Core.
@riverpod
Dio dio(DioRef ref) {
  return ref.watch(networkDioProvider);
}

/// 🔐 **Proveedor de Secure Storage**
///
/// Instancia única para acceso al Keychain/Keystore.
@riverpod
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage();
}

/// 👆 **Proveedor de Autenticación Local**
///
/// Instancia para acceder al hardware biométrico.
@riverpod
LocalAuthentication localAuth(LocalAuthRef ref) {
  return LocalAuthentication();
}

/// 💾 **Proveedor de DataSource Local**
@riverpod
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  return AuthLocalDataSource(ref.watch(secureStorageProvider));
}

/// ☁️ **Proveedor de DataSource Remoto**
@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSource(ref.watch(dioProvider));
}

/// 🛡️ **Proveedor de Repositorio de Auth**
///
/// Inyecta las dependencias necesarias para la implementación del repositorio.
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
    localAuth: ref.watch(localAuthProvider),
  );
}

/// 🧠 **Controlador de Autenticación (StateNotifier)**
///
/// Gestiona el estado global de la sesión del usuario.
/// Mantiene el objeto [UserEntity] si hay sesión activa, o `null` si no.
///
/// **Responsabilidades:**
/// - Verificar sesión al inicio (Hydration).
/// - Ejecutar Login/Registro y actualizar estado.
/// - Manejar Logout y limpieza de estado.
/// - Exponer métodos para biometría.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  /// 🏗️ **Construcción Inicial (Hydration)**
  ///
  /// 1. Busca token en almacenamiento seguro.
  /// 2. Si existe, valida contra el backend (/me).
  /// 3. Si es válido, retorna el usuario. Si no, limpia todo.
  @override
  Future<UserEntity?> build() async {
    // Try to get token from secure storage
    final token = await ref.read(authLocalDataSourceProvider).getToken();

    if (token == null) {
      return null;
    }

    // Try to get current user
    final result = await ref.read(authRepositoryProvider).getCurrentUser();

    return result.fold(
      (failure) {
        // Token is invalid, clear it
        ref.read(authLocalDataSourceProvider).clearAuthData();
        return null;
      },
      (user) => user,
    );
  }

  /// 🔑 **Iniciar Sesión**
  ///
  /// Actualiza el estado a [AsyncLoading] mientras procesa.
  /// Si falla, lanza excepción para que la UI muestre error.
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    final result = await ref.read(authRepositoryProvider).login(
          email: email,
          password: password,
        );

    state = await AsyncValue.guard(() async {
      return result.fold(
        (failure) => throw Exception(failure.message),
        (authResponse) {
          // Token is saved by AuthRepositoryImpl -> AuthLocalDataSource
          return authResponse.user;
        },
      );
    });
  }

  /// 📝 **Registrar Nuevo Usuario**
  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    // We don't update state here because registration might not return a token
    // or we want to force login.
    // The UI will handle the navigation to login.
    final result = await ref.read(authRepositoryProvider).register(
          username: username,
          email: email,
          password: password,
        );
    
    // Check for error
    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (success) => state = const AsyncData(null),
    );
  }

  /// 🚪 **Cerrar Sesión**
  ///
  /// Limpia el estado y el almacenamiento local.
  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }

  /// 👆 **Verificar Biometría**
  Future<bool> verifyBiometric() async {
    final result = await ref.read(authRepositoryProvider).verifyBiometric();
    return result.fold(
      (failure) => false,
      (success) => success,
    );
  }

  /// 📱 **Disponibilidad Biométrica**
  Future<bool> isBiometricAvailable() async {
    final result =
        await ref.read(authRepositoryProvider).isBiometricAvailable();
    return result.fold(
      (failure) => false,
      (available) => available,
    );
  }
}

/// 👤 **Proveedor del Usuario Actual**
///
/// Acceso directo al usuario autenticado (si existe).
@riverpod
UserEntity? currentUser(CurrentUserRef ref) {
  return ref.watch(authControllerProvider).value;
}
