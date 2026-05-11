import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/offline_service.dart';
import '../../../../core/local/schemas/post_schema.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_datasource.dart';
import '../mappers/post_mapper.dart';

/// 🛡️ **Implementación del Repositorio de Feed**
///
/// Orquesta la obtención y persistencia de publicaciones.
/// Implementa la estrategia "Network First, Fallback to Cache".
///
/// **Responsabilidades:**
/// - Obtener posts de la API y guardarlos en Isar.
/// - Servir contenido offline si falla la red.
/// - Gestionar actualizaciones optimistas (Likes).
/// - Encolar peticiones de escritura cuando está offline.
class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;
  final OfflineService offlineService;

  FeedRepositoryImpl({
    required this.remoteDataSource,
    required this.offlineService,
  });

  /// 📰 **Obtener Feed (Smart Sync)**
  ///
  /// 1. Intenta obtener datos frescos de la red.
  /// 2. Si tiene éxito, actualiza la caché local (Isar).
  /// 3. Si falla la red, retorna datos cacheados.
  @override
  Future<Either<Failure, List<PostEntity>>> getFeed({
    required int offset,
    required int limit,
  }) async {
    // 1. Try Network
    try {
      final remotePosts = await remoteDataSource.getFeed(
        offset: offset,
        limit: limit,
      );

      // 2. Save to Local (Cache)
      if (offlineService.db.isOpen) {
        final schemas = remotePosts.map((p) => PostMapper.toSchema(p)).toList();
        await offlineService.saveAll(schemas);
      }

      // 3. Return Remote
      return Right(remotePosts.map((p) => p.toEntity()).toList());
    } catch (e) {
      // 4. Fallback to Local
      if (offlineService.db.isOpen) {
        try {
          final localPosts = await offlineService.db.postSchemas
              .where()
              .sortByCreatedAtDesc()
              .offset(offset)
              .limit(limit)
              .findAll();
          
          if (localPosts.isNotEmpty) {
            return Right(localPosts.map((s) => PostMapper.fromSchema(s)).toList());
          }
        } catch (dbError) {
          // Ignore DB error and return original error
        }
      }
      
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// ❤️ **Dar Like (Optimista)**
  ///
  /// 1. Actualiza la UI inmediatamente (Local DB).
  /// 2. Llama a la API.
  /// 3. Si falla la red, encola la petición para reintentar luego.
  @override
  Future<Either<Failure, Unit>> likePost(String postId) async {
    try {
      // Optimistic Local Update
      await _updateLocalLikeStatus(postId, true);
      
      // Network Call
      await remoteDataSource.likePost(postId);
      return const Right(unit);
    } catch (e) {
      // Queue Request if offline
      await offlineService.queueRequest(
        method: 'POST',
        url: '/posts/$postId/like',
      );
      return const Right(unit); // Return success for optimistic UI
    }
  }

  /// 💔 **Quitar Like (Optimista)**
  @override
  Future<Either<Failure, Unit>> unlikePost(String postId) async {
    try {
      await _updateLocalLikeStatus(postId, false);
      await remoteDataSource.unlikePost(postId);
      return const Right(unit);
    } catch (e) {
      await offlineService.queueRequest(
        method: 'DELETE',
        url: '/posts/$postId/like',
      );
      return const Right(unit);
    }
  }

  /// 🔄 **Actualizar Estado Local**
  ///
  /// Helper para modificar el contador de likes en Isar sin red.
  Future<void> _updateLocalLikeStatus(String postId, bool isLiked) async {
    if (!offlineService.db.isOpen) return;
    
    final post = await offlineService.db.postSchemas.getByPostId(postId);
    if (post != null) {
      post.isLiked = isLiked;
      post.likesCount = isLiked ? post.likesCount + 1 : post.likesCount - 1;
      post.needsSync = true;
      await offlineService.save(post);
    }
  }

  /// 🔖 **Guardar Post**
  @override
  Future<Either<Failure, Unit>> bookmarkPost(String postId) async {
    try {
      await remoteDataSource.bookmarkPost(postId);
      return const Right(unit);
    } catch (e) {
      await offlineService.queueRequest(
        method: 'POST',
        url: '/posts/$postId/bookmark',
      );
      return const Right(unit);
    }
  }

  /// 🗑️ **Quitar Bookmark**
  @override
  Future<Either<Failure, Unit>> unbookmarkPost(String postId) async {
    try {
      await remoteDataSource.unbookmarkPost(postId);
      return const Right(unit);
    } catch (e) {
      await offlineService.queueRequest(
        method: 'DELETE',
        url: '/posts/$postId/bookmark',
      );
      return const Right(unit);
    }
  }

  /// 🔍 **Obtener Post Detallado**
  ///
  /// Intenta red, si falla busca en caché local.
  @override
  Future<Either<Failure, PostEntity>> getPostById(String postId) async {
    try {
      final post = await remoteDataSource.getPostById(postId);
      return Right(post.toEntity());
    } catch (e) {
      // Try local
      if (offlineService.db.isOpen) {
         final localPost = await offlineService.db.postSchemas.getByPostId(postId);
         if (localPost != null) {
           return Right(PostMapper.fromSchema(localPost));
         }
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// 🗑️ **Borrar Post**
  @override
  Future<Either<Failure, Unit>> deletePost(String postId) async {
    try {
      await remoteDataSource.deletePost(postId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// 💬 **Obtener Comentarios**
  @override
  Future<Either<Failure, List<CommentEntity>>> getComments({
    required String postId,
    required int offset,
    required int limit,
  }) async {
    try {
      final comments = await remoteDataSource.getComments(
        postId: postId,
        offset: offset,
        limit: limit,
      );
      return Right(comments.map((c) => c.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// ➕ **Agregar Comentario**
  @override
  Future<Either<Failure, CommentEntity>> addComment({
    required String postId,
    required String content,
  }) async {
    try {
      final comment = await remoteDataSource.addComment(
        postId: postId,
        content: content,
      );
      return Right(comment.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// ❤️ **Like Comentario**
  @override
  Future<Either<Failure, Unit>> likeComment(String commentId) async {
    try {
      await remoteDataSource.likeComment(commentId);
      return const Right(unit);
    } catch (e) {
      await offlineService.queueRequest(
        method: 'POST',
        url: '/posts/comments/$commentId/like',
      );
      return const Right(unit);
    }
  }

  /// 💔 **Unlike Comentario**
  @override
  Future<Either<Failure, Unit>> unlikeComment(String commentId) async {
    try {
      await remoteDataSource.unlikeComment(commentId);
      return const Right(unit);
    } catch (e) {
      await offlineService.queueRequest(
        method: 'DELETE',
        url: '/posts/comments/$commentId/like',
      );
      return const Right(unit);
    }
  }

  /// 🗑️ **Borrar Comentario**
  @override
  Future<Either<Failure, Unit>> deleteComment(String commentId) async {
    try {
      await remoteDataSource.deleteComment(commentId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
