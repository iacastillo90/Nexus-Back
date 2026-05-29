// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifyDataSourceHash() => r'5bad5e92a276c4494fb445319cadc483aa6a4e86';

/// Verify datasource provider
///
/// Copied from [verifyDataSource].
@ProviderFor(verifyDataSource)
final verifyDataSourceProvider = AutoDisposeProvider<VerifyDataSource>.internal(
  verifyDataSource,
  name: r'verifyDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifyDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VerifyDataSourceRef = AutoDisposeProviderRef<VerifyDataSource>;
String _$verifyRepositoryHash() => r'6659d5d4cc92389d1ec5c7f27d5e73b9e59267cf';

/// Verify repository provider
///
/// Copied from [verifyRepository].
@ProviderFor(verifyRepository)
final verifyRepositoryProvider = AutoDisposeProvider<VerifyRepository>.internal(
  verifyRepository,
  name: r'verifyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VerifyRepositoryRef = AutoDisposeProviderRef<VerifyRepository>;
String _$verificationResultHash() =>
    r'd4bc4bb4d2df133760a63a1b87cf25d54f235a17';

/// Verification result provider
///
/// Copied from [VerificationResult].
@ProviderFor(VerificationResult)
final verificationResultProvider = AutoDisposeAsyncNotifierProvider<
    VerificationResult, VerificationResultEntity?>.internal(
  VerificationResult.new,
  name: r'verificationResultProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verificationResultHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VerificationResult
    = AutoDisposeAsyncNotifier<VerificationResultEntity?>;
String _$contentDNAHash() => r'd6d72918789b8a05845bd81e51e52fa778975e21';

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

abstract class _$ContentDNA extends BuildlessAutoDisposeAsyncNotifier<String?> {
  late final String contentId;

  FutureOr<String?> build(
    String contentId,
  );
}

/// Content DNA provider
///
/// Copied from [ContentDNA].
@ProviderFor(ContentDNA)
const contentDNAProvider = ContentDNAFamily();

/// Content DNA provider
///
/// Copied from [ContentDNA].
class ContentDNAFamily extends Family<AsyncValue<String?>> {
  /// Content DNA provider
  ///
  /// Copied from [ContentDNA].
  const ContentDNAFamily();

  /// Content DNA provider
  ///
  /// Copied from [ContentDNA].
  ContentDNAProvider call(
    String contentId,
  ) {
    return ContentDNAProvider(
      contentId,
    );
  }

  @override
  ContentDNAProvider getProviderOverride(
    covariant ContentDNAProvider provider,
  ) {
    return call(
      provider.contentId,
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
  String? get name => r'contentDNAProvider';
}

/// Content DNA provider
///
/// Copied from [ContentDNA].
class ContentDNAProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ContentDNA, String?> {
  /// Content DNA provider
  ///
  /// Copied from [ContentDNA].
  ContentDNAProvider(
    String contentId,
  ) : this._internal(
          () => ContentDNA()..contentId = contentId,
          from: contentDNAProvider,
          name: r'contentDNAProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$contentDNAHash,
          dependencies: ContentDNAFamily._dependencies,
          allTransitiveDependencies:
              ContentDNAFamily._allTransitiveDependencies,
          contentId: contentId,
        );

  ContentDNAProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contentId,
  }) : super.internal();

  final String contentId;

  @override
  FutureOr<String?> runNotifierBuild(
    covariant ContentDNA notifier,
  ) {
    return notifier.build(
      contentId,
    );
  }

  @override
  Override overrideWith(ContentDNA Function() create) {
    return ProviderOverride(
      origin: this,
      override: ContentDNAProvider._internal(
        () => create()..contentId = contentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contentId: contentId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ContentDNA, String?> createElement() {
    return _ContentDNAProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ContentDNAProvider && other.contentId == contentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ContentDNARef on AutoDisposeAsyncNotifierProviderRef<String?> {
  /// The parameter `contentId` of this provider.
  String get contentId;
}

class _ContentDNAProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ContentDNA, String?>
    with ContentDNARef {
  _ContentDNAProviderElement(super.provider);

  @override
  String get contentId => (origin as ContentDNAProvider).contentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
