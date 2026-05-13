// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedRemoteDataSourceHash() =>
    r'5dc4404a9398155be34b67c3cb00e216426a19b8';

/// ☁️ **Proveedor de DataSource Remoto (Feed)**
///
/// Copied from [feedRemoteDataSource].
@ProviderFor(feedRemoteDataSource)
final feedRemoteDataSourceProvider =
    AutoDisposeProvider<FeedRemoteDataSource>.internal(
  feedRemoteDataSource,
  name: r'feedRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FeedRemoteDataSourceRef = AutoDisposeProviderRef<FeedRemoteDataSource>;
String _$feedRepositoryHash() => r'1405c48c2e014dd3abd4fc67d0b83041d85fba41';

/// 🛡️ **Proveedor de Repositorio (Feed)**
///
/// Inyecta la estrategia Offline-First (Remote + Local DB).
///
/// Copied from [feedRepository].
@ProviderFor(feedRepository)
final feedRepositoryProvider = AutoDisposeProvider<FeedRepository>.internal(
  feedRepository,
  name: r'feedRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FeedRepositoryRef = AutoDisposeProviderRef<FeedRepository>;
String _$feedControllerHash() => r'717a72c8885e80bfe832e0ebf063688cc920eeba';

/// 📰 **Controlador del Feed (Infinite Scroll)**
///
/// Gestiona la lista de posts del feed principal.
/// Soporta paginación, pull-to-refresh y actualizaciones optimistas.
///
/// **Estado:**
/// - [AsyncValue<List<PostEntity>>]: Lista de posts cargados.
///
/// Copied from [FeedController].
@ProviderFor(FeedController)
final feedControllerProvider =
    AutoDisposeAsyncNotifierProvider<FeedController, List<PostEntity>>.internal(
  FeedController.new,
  name: r'feedControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FeedController = AutoDisposeAsyncNotifier<List<PostEntity>>;
String _$postDetailControllerHash() =>
    r'27932ee27dfb94677b97bacc58c3cb550e1d2160';

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

abstract class _$PostDetailController
    extends BuildlessAutoDisposeNotifier<PostDetailState> {
  late final String postId;

  PostDetailState build(
    String postId,
  );
}

/// 💬 **Controlador de Detalle de Post**
///
/// Gestiona la vista individual de un post y sus comentarios.
///
/// **Argumentos:**
/// - [postId]: ID del post a cargar.
///
/// Copied from [PostDetailController].
@ProviderFor(PostDetailController)
const postDetailControllerProvider = PostDetailControllerFamily();

/// 💬 **Controlador de Detalle de Post**
///
/// Gestiona la vista individual de un post y sus comentarios.
///
/// **Argumentos:**
/// - [postId]: ID del post a cargar.
///
/// Copied from [PostDetailController].
class PostDetailControllerFamily extends Family<PostDetailState> {
  /// 💬 **Controlador de Detalle de Post**
  ///
  /// Gestiona la vista individual de un post y sus comentarios.
  ///
  /// **Argumentos:**
  /// - [postId]: ID del post a cargar.
  ///
  /// Copied from [PostDetailController].
  const PostDetailControllerFamily();

  /// 💬 **Controlador de Detalle de Post**
  ///
  /// Gestiona la vista individual de un post y sus comentarios.
  ///
  /// **Argumentos:**
  /// - [postId]: ID del post a cargar.
  ///
  /// Copied from [PostDetailController].
  PostDetailControllerProvider call(
    String postId,
  ) {
    return PostDetailControllerProvider(
      postId,
    );
  }

  @override
  PostDetailControllerProvider getProviderOverride(
    covariant PostDetailControllerProvider provider,
  ) {
    return call(
      provider.postId,
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
  String? get name => r'postDetailControllerProvider';
}

/// 💬 **Controlador de Detalle de Post**
///
/// Gestiona la vista individual de un post y sus comentarios.
///
/// **Argumentos:**
/// - [postId]: ID del post a cargar.
///
/// Copied from [PostDetailController].
class PostDetailControllerProvider extends AutoDisposeNotifierProviderImpl<
    PostDetailController, PostDetailState> {
  /// 💬 **Controlador de Detalle de Post**
  ///
  /// Gestiona la vista individual de un post y sus comentarios.
  ///
  /// **Argumentos:**
  /// - [postId]: ID del post a cargar.
  ///
  /// Copied from [PostDetailController].
  PostDetailControllerProvider(
    String postId,
  ) : this._internal(
          () => PostDetailController()..postId = postId,
          from: postDetailControllerProvider,
          name: r'postDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postDetailControllerHash,
          dependencies: PostDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              PostDetailControllerFamily._allTransitiveDependencies,
          postId: postId,
        );

  PostDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  PostDetailState runNotifierBuild(
    covariant PostDetailController notifier,
  ) {
    return notifier.build(
      postId,
    );
  }

  @override
  Override overrideWith(PostDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostDetailControllerProvider._internal(
        () => create()..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PostDetailController, PostDetailState>
      createElement() {
    return _PostDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostDetailControllerProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostDetailControllerRef
    on AutoDisposeNotifierProviderRef<PostDetailState> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _PostDetailControllerProviderElement
    extends AutoDisposeNotifierProviderElement<PostDetailController,
        PostDetailState> with PostDetailControllerRef {
  _PostDetailControllerProviderElement(super.provider);

  @override
  String get postId => (origin as PostDetailControllerProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
