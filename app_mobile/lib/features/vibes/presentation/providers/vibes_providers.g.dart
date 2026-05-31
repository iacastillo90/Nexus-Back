// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vibes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$vibesRemoteDataSourceHash() =>
    r'f926bbe50b58853207b86e35ee092a1151ea35d0';

/// Vibes remote datasource provider
///
/// Copied from [vibesRemoteDataSource].
@ProviderFor(vibesRemoteDataSource)
final vibesRemoteDataSourceProvider =
    AutoDisposeProvider<VibesRemoteDataSource>.internal(
  vibesRemoteDataSource,
  name: r'vibesRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$vibesRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VibesRemoteDataSourceRef
    = AutoDisposeProviderRef<VibesRemoteDataSource>;
String _$vibesRepositoryHash() => r'4d17e3148faee34793482c36d6432a2912104cc8';

/// Vibes repository provider
///
/// Copied from [vibesRepository].
@ProviderFor(vibesRepository)
final vibesRepositoryProvider = AutoDisposeProvider<VibesRepository>.internal(
  vibesRepository,
  name: r'vibesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$vibesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VibesRepositoryRef = AutoDisposeProviderRef<VibesRepository>;
String _$userVibesHash() => r'ebd8cd1ac4f22ee5faae293dbe06e0181b40c35b';

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

abstract class _$UserVibes
    extends BuildlessAutoDisposeAsyncNotifier<VibesEntity> {
  late final String userId;

  FutureOr<VibesEntity> build(
    String userId,
  );
}

/// User vibes provider
///
/// Copied from [UserVibes].
@ProviderFor(UserVibes)
const userVibesProvider = UserVibesFamily();

/// User vibes provider
///
/// Copied from [UserVibes].
class UserVibesFamily extends Family<AsyncValue<VibesEntity>> {
  /// User vibes provider
  ///
  /// Copied from [UserVibes].
  const UserVibesFamily();

  /// User vibes provider
  ///
  /// Copied from [UserVibes].
  UserVibesProvider call(
    String userId,
  ) {
    return UserVibesProvider(
      userId,
    );
  }

  @override
  UserVibesProvider getProviderOverride(
    covariant UserVibesProvider provider,
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
  String? get name => r'userVibesProvider';
}

/// User vibes provider
///
/// Copied from [UserVibes].
class UserVibesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserVibes, VibesEntity> {
  /// User vibes provider
  ///
  /// Copied from [UserVibes].
  UserVibesProvider(
    String userId,
  ) : this._internal(
          () => UserVibes()..userId = userId,
          from: userVibesProvider,
          name: r'userVibesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userVibesHash,
          dependencies: UserVibesFamily._dependencies,
          allTransitiveDependencies: UserVibesFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserVibesProvider._internal(
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
  FutureOr<VibesEntity> runNotifierBuild(
    covariant UserVibes notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserVibes Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserVibesProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserVibes, VibesEntity>
      createElement() {
    return _UserVibesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserVibesProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserVibesRef on AutoDisposeAsyncNotifierProviderRef<VibesEntity> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserVibesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserVibes, VibesEntity>
    with UserVibesRef {
  _UserVibesProviderElement(super.provider);

  @override
  String get userId => (origin as UserVibesProvider).userId;
}

String _$communityPulseHash() => r'09759956f57fa016cd0fc4021d87acbd825fbd01';

/// Community pulse provider
///
/// Copied from [CommunityPulse].
@ProviderFor(CommunityPulse)
final communityPulseProvider = AutoDisposeAsyncNotifierProvider<CommunityPulse,
    Map<String, double>>.internal(
  CommunityPulse.new,
  name: r'communityPulseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$communityPulseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CommunityPulse = AutoDisposeAsyncNotifier<Map<String, double>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
