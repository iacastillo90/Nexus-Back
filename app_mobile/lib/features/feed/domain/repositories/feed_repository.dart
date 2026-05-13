import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';
import '../entities/comment_entity.dart';

/// 📰 **Repositorio de Feed (Contrato)**
///
/// Define las operaciones para interactuar con el flujo de publicaciones.
/// Soporta paginación, interacciones y comentarios.
///
/// **Responsabilidades:**
/// - Lectura de posts (Feed).
/// - Interacciones (Like, Bookmark).
/// - Gestión de Comentarios.
///
/// **Implementación:**
/// - Ver `lib/features/feed/data/repositories/feed_repository_impl.dart`
abstract class FeedRepository {
  /// 📜 **Obtener Feed Paginado**
  ///
  /// Recupera una lista de posts.
  ///
  /// **Parámetros:**
  /// - [offset]: Índice de inicio.
  /// - [limit]: Cantidad de posts a traer.
  Future<Either<Failure, List<PostEntity>>> getFeed({
    required int offset,
    required int limit,
  });

  /// ❤️ **Dar Like a Post**
  Future<Either<Failure, Unit>> likePost(String postId);

  /// 💔 **Quitar Like a Post**
  Future<Either<Failure, Unit>> unlikePost(String postId);

  /// 🔖 **Guardar Post (Bookmark)**
  Future<Either<Failure, Unit>> bookmarkPost(String postId);

  /// 🗑️ **Quitar Bookmark**
  Future<Either<Failure, Unit>> unbookmarkPost(String postId);

  /// 🔍 **Obtener Post por ID**
  Future<Either<Failure, PostEntity>> getPostById(String postId);

  /// 🗑️ **Borrar Post**
  Future<Either<Failure, Unit>> deletePost(String postId);

  /// 💬 **Obtener Comentarios**
  Future<Either<Failure, List<CommentEntity>>> getComments({
    required String postId,
    required int offset,
    required int limit,
  });

  /// ➕ **Agregar Comentario**
  Future<Either<Failure, CommentEntity>> addComment({
    required String postId,
    required String content,
  });

  /// ❤️ **Dar Like a Comentario**
  Future<Either<Failure, Unit>> likeComment(String commentId);

  /// 💔 **Quitar Like a Comentario**
  Future<Either<Failure, Unit>> unlikeComment(String commentId);

  /// 🗑️ **Borrar Comentario**
  Future<Either<Failure, Unit>> deleteComment(String commentId);
}
