// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dreams_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dreamsDataSourceHash() => r'f6eb12b66ff56473bcbfd444ae7009832172c119';

/// Dreams datasource provider
///
/// Copied from [dreamsDataSource].
@ProviderFor(dreamsDataSource)
final dreamsDataSourceProvider = AutoDisposeProvider<DreamsDataSource>.internal(
  dreamsDataSource,
  name: r'dreamsDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dreamsDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DreamsDataSourceRef = AutoDisposeProviderRef<DreamsDataSource>;
String _$dreamsRepositoryHash() => r'54d38cf16b40de07c73a95a7f98b3f4a0b09ba4b';

/// Dreams repository provider
///
/// Copied from [dreamsRepository].
@ProviderFor(dreamsRepository)
final dreamsRepositoryProvider = AutoDisposeProvider<DreamsRepository>.internal(
  dreamsRepository,
  name: r'dreamsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dreamsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DreamsRepositoryRef = AutoDisposeProviderRef<DreamsRepository>;
String _$dreamsListHash() => r'faf15708a03c31f0b645ac4f9506fec4578cb49b';

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

abstract class _$DreamsList
    extends BuildlessAutoDisposeAsyncNotifier<List<DreamEntity>> {
  late final DreamStatus? status;

  FutureOr<List<DreamEntity>> build({
    DreamStatus? status,
  });
}

/// Dreams list provider
///
/// Copied from [DreamsList].
@ProviderFor(DreamsList)
const dreamsListProvider = DreamsListFamily();

/// Dreams list provider
///
/// Copied from [DreamsList].
class DreamsListFamily extends Family<AsyncValue<List<DreamEntity>>> {
  /// Dreams list provider
  ///
  /// Copied from [DreamsList].
  const DreamsListFamily();

  /// Dreams list provider
  ///
  /// Copied from [DreamsList].
  DreamsListProvider call({
    DreamStatus? status,
  }) {
    return DreamsListProvider(
      status: status,
    );
  }

  @override
  DreamsListProvider getProviderOverride(
    covariant DreamsListProvider provider,
  ) {
    return call(
      status: provider.status,
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
  String? get name => r'dreamsListProvider';
}

/// Dreams list provider
///
/// Copied from [DreamsList].
class DreamsListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DreamsList, List<DreamEntity>> {
  /// Dreams list provider
  ///
  /// Copied from [DreamsList].
  DreamsListProvider({
    DreamStatus? status,
  }) : this._internal(
          () => DreamsList()..status = status,
          from: dreamsListProvider,
          name: r'dreamsListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dreamsListHash,
          dependencies: DreamsListFamily._dependencies,
          allTransitiveDependencies:
              DreamsListFamily._allTransitiveDependencies,
          status: status,
        );

  DreamsListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final DreamStatus? status;

  @override
  FutureOr<List<DreamEntity>> runNotifierBuild(
    covariant DreamsList notifier,
  ) {
    return notifier.build(
      status: status,
    );
  }

  @override
  Override overrideWith(DreamsList Function() create) {
    return ProviderOverride(
      origin: this,
      override: DreamsListProvider._internal(
        () => create()..status = status,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DreamsList, List<DreamEntity>>
      createElement() {
    return _DreamsListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DreamsListProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DreamsListRef on AutoDisposeAsyncNotifierProviderRef<List<DreamEntity>> {
  /// The parameter `status` of this provider.
  DreamStatus? get status;
}

class _DreamsListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DreamsList,
        List<DreamEntity>> with DreamsListRef {
  _DreamsListProviderElement(super.provider);

  @override
  DreamStatus? get status => (origin as DreamsListProvider).status;
}

String _$dreamDetailHash() => r'8b511b4c8b8057e6d169400838fecda2d5cbd0c3';

abstract class _$DreamDetail
    extends BuildlessAutoDisposeAsyncNotifier<DreamEntity> {
  late final String dreamId;

  FutureOr<DreamEntity> build(
    String dreamId,
  );
}

/// Dream detail provider
///
/// Copied from [DreamDetail].
@ProviderFor(DreamDetail)
const dreamDetailProvider = DreamDetailFamily();

/// Dream detail provider
///
/// Copied from [DreamDetail].
class DreamDetailFamily extends Family<AsyncValue<DreamEntity>> {
  /// Dream detail provider
  ///
  /// Copied from [DreamDetail].
  const DreamDetailFamily();

  /// Dream detail provider
  ///
  /// Copied from [DreamDetail].
  DreamDetailProvider call(
    String dreamId,
  ) {
    return DreamDetailProvider(
      dreamId,
    );
  }

  @override
  DreamDetailProvider getProviderOverride(
    covariant DreamDetailProvider provider,
  ) {
    return call(
      provider.dreamId,
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
  String? get name => r'dreamDetailProvider';
}

/// Dream detail provider
///
/// Copied from [DreamDetail].
class DreamDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DreamDetail, DreamEntity> {
  /// Dream detail provider
  ///
  /// Copied from [DreamDetail].
  DreamDetailProvider(
    String dreamId,
  ) : this._internal(
          () => DreamDetail()..dreamId = dreamId,
          from: dreamDetailProvider,
          name: r'dreamDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dreamDetailHash,
          dependencies: DreamDetailFamily._dependencies,
          allTransitiveDependencies:
              DreamDetailFamily._allTransitiveDependencies,
          dreamId: dreamId,
        );

  DreamDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dreamId,
  }) : super.internal();

  final String dreamId;

  @override
  FutureOr<DreamEntity> runNotifierBuild(
    covariant DreamDetail notifier,
  ) {
    return notifier.build(
      dreamId,
    );
  }

  @override
  Override overrideWith(DreamDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: DreamDetailProvider._internal(
        () => create()..dreamId = dreamId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dreamId: dreamId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DreamDetail, DreamEntity>
      createElement() {
    return _DreamDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DreamDetailProvider && other.dreamId == dreamId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dreamId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DreamDetailRef on AutoDisposeAsyncNotifierProviderRef<DreamEntity> {
  /// The parameter `dreamId` of this provider.
  String get dreamId;
}

class _DreamDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DreamDetail, DreamEntity>
    with DreamDetailRef {
  _DreamDetailProviderElement(super.provider);

  @override
  String get dreamId => (origin as DreamDetailProvider).dreamId;
}

String _$dreamContributionsHash() =>
    r'eff491e7c68de7eb47372969be1c18eabbeed24f';

abstract class _$DreamContributions
    extends BuildlessAutoDisposeAsyncNotifier<List<DreamContributionEntity>> {
  late final String dreamId;

  FutureOr<List<DreamContributionEntity>> build(
    String dreamId,
  );
}

/// Dream contributions provider
///
/// Copied from [DreamContributions].
@ProviderFor(DreamContributions)
const dreamContributionsProvider = DreamContributionsFamily();

/// Dream contributions provider
///
/// Copied from [DreamContributions].
class DreamContributionsFamily
    extends Family<AsyncValue<List<DreamContributionEntity>>> {
  /// Dream contributions provider
  ///
  /// Copied from [DreamContributions].
  const DreamContributionsFamily();

  /// Dream contributions provider
  ///
  /// Copied from [DreamContributions].
  DreamContributionsProvider call(
    String dreamId,
  ) {
    return DreamContributionsProvider(
      dreamId,
    );
  }

  @override
  DreamContributionsProvider getProviderOverride(
    covariant DreamContributionsProvider provider,
  ) {
    return call(
      provider.dreamId,
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
  String? get name => r'dreamContributionsProvider';
}

/// Dream contributions provider
///
/// Copied from [DreamContributions].
class DreamContributionsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DreamContributions, List<DreamContributionEntity>> {
  /// Dream contributions provider
  ///
  /// Copied from [DreamContributions].
  DreamContributionsProvider(
    String dreamId,
  ) : this._internal(
          () => DreamContributions()..dreamId = dreamId,
          from: dreamContributionsProvider,
          name: r'dreamContributionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dreamContributionsHash,
          dependencies: DreamContributionsFamily._dependencies,
          allTransitiveDependencies:
              DreamContributionsFamily._allTransitiveDependencies,
          dreamId: dreamId,
        );

  DreamContributionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dreamId,
  }) : super.internal();

  final String dreamId;

  @override
  FutureOr<List<DreamContributionEntity>> runNotifierBuild(
    covariant DreamContributions notifier,
  ) {
    return notifier.build(
      dreamId,
    );
  }

  @override
  Override overrideWith(DreamContributions Function() create) {
    return ProviderOverride(
      origin: this,
      override: DreamContributionsProvider._internal(
        () => create()..dreamId = dreamId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dreamId: dreamId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DreamContributions,
      List<DreamContributionEntity>> createElement() {
    return _DreamContributionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DreamContributionsProvider && other.dreamId == dreamId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dreamId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DreamContributionsRef
    on AutoDisposeAsyncNotifierProviderRef<List<DreamContributionEntity>> {
  /// The parameter `dreamId` of this provider.
  String get dreamId;
}

class _DreamContributionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DreamContributions,
        List<DreamContributionEntity>> with DreamContributionsRef {
  _DreamContributionsProviderElement(super.provider);

  @override
  String get dreamId => (origin as DreamContributionsProvider).dreamId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
