// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileDataSourceHash() => r'809155dbcf7c3cc7f519348fa524b0a5256876d0';

/// ☁️ **Proveedor de DataSource (Profile)**
///
/// Copied from [profileDataSource].
@ProviderFor(profileDataSource)
final profileDataSourceProvider =
    AutoDisposeProvider<ProfileDataSource>.internal(
  profileDataSource,
  name: r'profileDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProfileDataSourceRef = AutoDisposeProviderRef<ProfileDataSource>;
String _$profileRepositoryHash() => r'9393813863acf5d4f0e51adfca2022931f6d0329';

/// 🛡️ **Proveedor de Repositorio (Profile)**
///
/// Copied from [profileRepository].
@ProviderFor(profileRepository)
final profileRepositoryProvider =
    AutoDisposeProvider<ProfileRepository>.internal(
  profileRepository,
  name: r'profileRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProfileRepositoryRef = AutoDisposeProviderRef<ProfileRepository>;
String _$currentProfileHash() => r'5a4b00434fc5e316b06d0f5bf3864f794d41a8e2';

/// 👤 **Controlador del Perfil Actual**
///
/// Gestiona el estado del perfil del usuario logueado.
/// Permite editar datos y ver estadísticas propias.
///
/// Copied from [CurrentProfile].
@ProviderFor(CurrentProfile)
final currentProfileProvider =
    AutoDisposeAsyncNotifierProvider<CurrentProfile, ProfileEntity>.internal(
  CurrentProfile.new,
  name: r'currentProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentProfile = AutoDisposeAsyncNotifier<ProfileEntity>;
String _$userProfileHash() => r'ab196adb7d097ec7b20f259ea4f2c722c2d73a42';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$UserProfile
    extends BuildlessAutoDisposeAsyncNotifier<ProfileEntity> {
  late final String userId;

  FutureOr<ProfileEntity> build(
    String userId,
  );
}

/// 👥 **Controlador de Perfil de Usuario**
///
/// Gestiona la vista del perfil de OTRO usuario.
/// Permite seguir/dejar de seguir.
///
/// **Argumentos:**
/// - [userId]: ID del usuario a visualizar.
///
/// Copied from [UserProfile].
@ProviderFor(UserProfile)
const userProfileProvider = UserProfileFamily();

/// 👥 **Controlador de Perfil de Usuario**
///
/// Gestiona la vista del perfil de OTRO usuario.
/// Permite seguir/dejar de seguir.
///
/// **Argumentos:**
/// - [userId]: ID del usuario a visualizar.
///
/// Copied from [UserProfile].
class UserProfileFamily extends Family<AsyncValue<ProfileEntity>> {
  /// 👥 **Controlador de Perfil de Usuario**
  ///
  /// Gestiona la vista del perfil de OTRO usuario.
  /// Permite seguir/dejar de seguir.
  ///
  /// **Argumentos:**
  /// - [userId]: ID del usuario a visualizar.
  ///
  /// Copied from [UserProfile].
  const UserProfileFamily();

  /// 👥 **Controlador de Perfil de Usuario**
  ///
  /// Gestiona la vista del perfil de OTRO usuario.
  /// Permite seguir/dejar de seguir.
  ///
  /// **Argumentos:**
  /// - [userId]: ID del usuario a visualizar.
  ///
  /// Copied from [UserProfile].
  UserProfileProvider call(
    String userId,
  ) {
    return UserProfileProvider(
      userId,
    );
  }

  @override
  UserProfileProvider getProviderOverride(
    covariant UserProfileProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userProfileProvider';
}

/// 👥 **Controlador de Perfil de Usuario**
///
/// Gestiona la vista del perfil de OTRO usuario.
/// Permite seguir/dejar de seguir.
///
/// **Argumentos:**
/// - [userId]: ID del usuario a visualizar.
///
/// Copied from [UserProfile].
class UserProfileProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserProfile, ProfileEntity> {
  /// 👥 **Controlador de Perfil de Usuario**
  ///
  /// Gestiona la vista del perfil de OTRO usuario.
  /// Permite seguir/dejar de seguir.
  ///
  /// **Argumentos:**
  /// - [userId]: ID del usuario a visualizar.
  ///
  /// Copied from [UserProfile].
  UserProfileProvider(
    String userId,
  ) : this._internal(
          () => UserProfile()..userId = userId,
          from: userProfileProvider,
          name: r'userProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileHash,
          dependencies: UserProfileFamily._dependencies,
          allTransitiveDependencies:
              UserProfileFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<ProfileEntity> runNotifierBuild(
    covariant UserProfile notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserProfile Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserProfileProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UserProfile, ProfileEntity>
      createElement() {
    return _UserProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserProfileRef on AutoDisposeAsyncNotifierProviderRef<ProfileEntity> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserProfileProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserProfile, ProfileEntity>
    with UserProfileRef {
  _UserProfileProviderElement(super.provider);

  @override
  String get userId => (origin as UserProfileProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
