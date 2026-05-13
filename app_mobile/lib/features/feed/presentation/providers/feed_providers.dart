import 'package:nexus_mobile/core/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../../core/services/offline_service.dart';
import '../../data/datasources/feed_remote_datasource.dart';
import '../../data/repositories/feed_repository_impl.dart';
import '../../domain/repositories/feed_repository.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/comment_entity.dart';

part 'feed_providers.g.dart';

/// ☁️ **Proveedor de DataSource Remoto (Feed)**
@riverpod
FeedRemoteDataSource feedRemoteDataSource(FeedRemoteDataSourceRef ref) {
  return FeedRemoteDataSource(ref.watch(networkDioProvider));
}

/// 🛡️ **Proveedor de Repositorio (Feed)**
///
/// Inyecta la estrategia Offline-First (Remote + Local DB).
@riverpod
FeedRepository feedRepository(FeedRepositoryRef ref) {
  return FeedRepositoryImpl(
    remoteDataSource: ref.watch(feedRemoteDataSourceProvider),
    offlineService: ref.watch(offlineServiceProvider),
  );
}

/// 📰 **Controlador del Feed (Infinite Scroll)**
///
/// Gestiona la lista de posts del feed principal.
/// Soporta paginación, pull-to-refresh y actualizaciones optimistas.
///
/// **Estado:**
/// - [AsyncValue<List<PostEntity>>]: Lista de posts cargados.
@riverpod
class FeedController extends _$FeedController {
  static const int _pageSize = 10;
  int _currentOffset = 0;
  bool _hasMore = true;

  /// 🏗️ **Carga Inicial**
  @override
  Future<List<PostEntity>> build() async {
    return await _loadPosts();
  }

  /// 📥 **Cargar Posts (Interno)**
  Future<List<PostEntity>> _loadPosts() async {
    final result = await ref.read(feedRepositoryProvider).getFeed(
          offset: 0,
          limit: _pageSize,
        );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (posts) {
        _currentOffset = posts.length;
        _hasMore = posts.length >= _pageSize;
        return posts;
      },
    );
  }

  /// 📜 **Cargar Más (Paginación)**
  ///
  /// Se llama al llegar al final de la lista.
  /// Agrega los nuevos posts al estado existente.
  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final currentPosts = state.value ?? [];

    final result = await ref.read(feedRepositoryProvider).getFeed(
          offset: _currentOffset,
          limit: _pageSize,
        );

    result.fold(
      (failure) {
        // Keep current state on error
      },
      (newPosts) {
        if (newPosts.isEmpty) {
          _hasMore = false;
        } else {
          _currentOffset += newPosts.length;
          _hasMore = newPosts.length >= _pageSize;
          state = AsyncData([...currentPosts, ...newPosts]);
        }
      },
    );
  }

  /// 🔄 **Refrescar Feed**
  ///
  /// Reinicia la paginación y recarga desde cero.
  Future<void> refresh() async {
    _currentOffset = 0;
    _hasMore = true;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadPosts());
  }

  /// ❤️ **Toggle Like (Optimista)**
  ///
  /// Actualiza la UI instantáneamente y luego sincroniza con el backend.
  /// Si falla, revierte el cambio.
  Future<void> toggleLike(String postId) async {
    final currentPosts = state.value ?? [];
    final postIndex = currentPosts.indexWhere((p) => p.id == postId);

    if (postIndex == -1) return;

    final post = currentPosts[postIndex];
    final isLiked = post.isLiked;

    // Optimistic update
    final updatedPost = post.copyWith(
      isLiked: !isLiked,
      likesCount: isLiked ? post.likesCount - 1 : post.likesCount + 1,
    );

    final updatedPosts = [...currentPosts];
    updatedPosts[postIndex] = updatedPost;
    state = AsyncData(updatedPosts);

    // API call
    final result = isLiked
        ? await ref.read(feedRepositoryProvider).unlikePost(postId)
        : await ref.read(feedRepositoryProvider).likePost(postId);

    result.fold(
      (failure) {
        // Revert on error
        state = AsyncData(currentPosts);
      },
      (_) {
        // Success - keep optimistic update
      },
    );
  }

  /// 🔖 **Toggle Bookmark (Optimista)**
  Future<void> toggleBookmark(String postId) async {
    final currentPosts = state.value ?? [];
    final postIndex = currentPosts.indexWhere((p) => p.id == postId);

    if (postIndex == -1) return;

    final post = currentPosts[postIndex];
    final isBookmarked = post.isBookmarked;

    // Optimistic update
    final updatedPost = post.copyWith(
      isBookmarked: !isBookmarked,
    );

    final updatedPosts = [...currentPosts];
    updatedPosts[postIndex] = updatedPost;
    state = AsyncData(updatedPosts);

    // API call
    final result = isBookmarked
        ? await ref.read(feedRepositoryProvider).unbookmarkPost(postId)
        : await ref.read(feedRepositoryProvider).bookmarkPost(postId);

    result.fold(
      (failure) {
        // Revert on error
        state = AsyncData(currentPosts);
      },
      (_) {
        // Success - keep optimistic update
      },
    );
  }

  /// 🏁 **¿Hay más posts?**
  bool get hasMore => _hasMore;
}

/// 📦 **Estado del Detalle del Post**
///
/// Contiene el post completo y su lista de comentarios.
class PostDetailState {
  final PostEntity? post;
  final List<CommentEntity> comments;
  final bool isLoadingPost;
  final bool isLoadingComments;
  final bool hasMoreComments;
  final String? error;

  PostDetailState({
    this.post,
    this.comments = const [],
    this.isLoadingPost = false,
    this.isLoadingComments = false,
    this.hasMoreComments = true,
    this.error,
  });

  PostDetailState copyWith({
    PostEntity? post,
    List<CommentEntity>? comments,
    bool? isLoadingPost,
    bool? isLoadingComments,
    bool? hasMoreComments,
    String? error,
  }) {
    return PostDetailState(
      post: post ?? this.post,
      comments: comments ?? this.comments,
      isLoadingPost: isLoadingPost ?? this.isLoadingPost,
      isLoadingComments: isLoadingComments ?? this.isLoadingComments,
      hasMoreComments: hasMoreComments ?? this.hasMoreComments,
      error: error ?? this.error,
    );
  }
}

/// 💬 **Controlador de Detalle de Post**
///
/// Gestiona la vista individual de un post y sus comentarios.
///
/// **Argumentos:**
/// - [postId]: ID del post a cargar.
@riverpod
class PostDetailController extends _$PostDetailController {
  static const int _pageSize = 20;
  int _currentOffset = 0;

  @override
  PostDetailState build(String postId) {
    _loadPostAndComments();
    return PostDetailState(isLoadingPost: true, isLoadingComments: true);
  }

  /// 📥 **Carga Inicial (Post + Comentarios)**
  Future<void> _loadPostAndComments() async {
    // Load post
    final postResult = await ref.read(feedRepositoryProvider).getPostById(postId);

    postResult.fold(
      (failure) {
        state = state.copyWith(
          isLoadingPost: false,
          error: failure.message,
        );
      },
      (post) {
        state = state.copyWith(
          post: post,
          isLoadingPost: false,
        );
      },
    );

    // Load comments
    await _loadComments();
  }

  /// 💬 **Cargar Comentarios**
  Future<void> _loadComments() async {
    final result = await ref.read(feedRepositoryProvider).getComments(
          postId: postId,
          offset: 0,
          limit: _pageSize,
        );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingComments: false,
          error: failure.message,
        );
      },
      (comments) {
        _currentOffset = comments.length;
        state = state.copyWith(
          comments: comments,
          isLoadingComments: false,
          hasMoreComments: comments.length >= _pageSize,
        );
      },
    );
  }

  /// 📜 **Cargar Más Comentarios**
  Future<void> loadMoreComments() async {
    if (!state.hasMoreComments || state.isLoadingComments) return;

    state = state.copyWith(isLoadingComments: true);

    final result = await ref.read(feedRepositoryProvider).getComments(
          postId: postId,
          offset: _currentOffset,
          limit: _pageSize,
        );

    result.fold(
      (failure) {
        state = state.copyWith(isLoadingComments: false);
      },
      (newComments) {
        if (newComments.isEmpty) {
          state = state.copyWith(
            hasMoreComments: false,
            isLoadingComments: false,
          );
        } else {
          _currentOffset += newComments.length;
          state = state.copyWith(
            comments: [...state.comments, ...newComments],
            isLoadingComments: false,
            hasMoreComments: newComments.length >= _pageSize,
          );
        }
      },
    );
  }

  /// ➕ **Agregar Comentario**
  Future<void> addComment(String content) async {
    final result = await ref.read(feedRepositoryProvider).addComment(
          postId: postId,
          content: content,
        );

    result.fold(
      (failure) {
        // Show error
      },
      (newComment) {
        // Add to beginning of list
        state = state.copyWith(
          comments: [newComment, ...state.comments],
        );

        // Update post comment count
        if (state.post != null) {
          state = state.copyWith(
            post: state.post!.copyWith(
              commentsCount: state.post!.commentsCount + 1,
            ),
          );
        }
      },
    );
  }

  /// ❤️ **Like Comentario (Optimista)**
  Future<void> toggleLikeComment(String commentId) async {
    final commentIndex = state.comments.indexWhere((c) => c.id == commentId);
    if (commentIndex == -1) return;

    final comment = state.comments[commentIndex];
    final isLiked = comment.isLiked;

    // Optimistic update
    final updatedComment = comment.copyWith(
      isLiked: !isLiked,
      likesCount: isLiked ? comment.likesCount - 1 : comment.likesCount + 1,
    );

    final updatedComments = [...state.comments];
    updatedComments[commentIndex] = updatedComment;
    state = state.copyWith(comments: updatedComments);

    // API call
    final result = isLiked
        ? await ref.read(feedRepositoryProvider).unlikeComment(commentId)
        : await ref.read(feedRepositoryProvider).likeComment(commentId);

    result.fold(
      (failure) {
        // Revert on error
        final revertedComments = [...state.comments];
        revertedComments[commentIndex] = comment;
        state = state.copyWith(comments: revertedComments);
      },
      (_) {
        // Success - keep optimistic update
      },
    );
  }

  /// 🔄 **Refrescar Todo**
  Future<void> refresh() async {
    _currentOffset = 0;
    state = PostDetailState(isLoadingPost: true, isLoadingComments: true);
    await _loadPostAndComments();
  }
}
