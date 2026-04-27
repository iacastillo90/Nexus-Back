// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'1f864ac4953e9547092a2ff31f01146cc86b5155';

/// 🌐 **Proveedor de Dio (Cliente HTTP)**
///
/// Expone la instancia configurada globalmente en el Core.
///
/// Copied from [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioRef = AutoDisposeProviderRef<Dio>;
String _$secureStorageHash() => r'77df30c7098a9f252222741225993ef719fafe36';

/// 🔐 **Proveedor de Secure Storage**
///
/// Instancia única para acceso al Keychain/Keystore.
///
/// Copied from [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider =
    AutoDisposeProvider<FlutterSecureStorage>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SecureStorageRef = AutoDisposeProviderRef<FlutterSecureStorage>;
String _$localAuthHash() => r'bbf192b2ad1b9c7d1ddfe510e02bae2bb4b66ff8';

/// 👆 **Proveedor de Autenticación Local**
///
/// Instancia para acceder al hardware biométrico.
///
/// Copied from [localAuth].
@ProviderFor(localAuth)
final localAuthProvider = AutoDisposeProvider<LocalAuthentication>.internal(
  localAuth,
  name: r'localAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$localAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalAuthRef = AutoDisposeProviderRef<LocalAuthentication>;
String _$authLocalDataSourceHash() =>
    r'817eabaea46e3933c9d6b63b40f9aa7bbea5155e';

/// 💾 **Proveedor de DataSource Local**
///
/// Copied from [authLocalDataSource].
@ProviderFor(authLocalDataSource)
final authLocalDataSourceProvider =
    AutoDisposeProvider<AuthLocalDataSource>.internal(
  authLocalDataSource,
  name: r'authLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthLocalDataSourceRef = AutoDisposeProviderRef<AuthLocalDataSource>;
String _$authRemoteDataSourceHash() =>
    r'9f3b831d60f7f09641f97c496d61fd9a12ad1ca5';

/// ☁️ **Proveedor de DataSource Remoto**
///
/// Copied from [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider =
    AutoDisposeProvider<AuthRemoteDataSource>.internal(
  authRemoteDataSource,
  name: r'authRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRemoteDataSourceRef = AutoDisposeProviderRef<AuthRemoteDataSource>;
String _$authRepositoryHash() => r'8b93dd5f6f1858a06ee217af77592c88cffc597b';

/// 🛡️ **Proveedor de Repositorio de Auth**
///
/// Inyecta las dependencias necesarias para la implementación del repositorio.
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$currentUserHash() => r'eedc106dbe01a517040155a218e214341d07c88d';

/// 👤 **Proveedor del Usuario Actual**
///
/// Acceso directo al usuario autenticado (si existe).
///
/// Copied from [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeProvider<UserEntity?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserRef = AutoDisposeProviderRef<UserEntity?>;
String _$authControllerHash() => r'592974a3e05b6ea4c50815a5801901c250033fc2';

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
///
/// Copied from [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AsyncNotifierProvider<AuthController, UserEntity?>.internal(
  AuthController.new,
  name: r'authControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthController = AsyncNotifier<UserEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
