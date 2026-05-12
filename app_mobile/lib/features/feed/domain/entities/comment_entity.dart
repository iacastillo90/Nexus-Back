import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_entity.freezed.dart';

/// 💬 **Entidad de Comentario**
///
/// Representa una respuesta textual de un usuario a una publicación.
///
/// **Responsabilidades:**
/// - Almacenar el contenido de la discusión.
/// - Vincular al autor con el post original.
/// - Rastrear la popularidad del comentario (likes).
///
/// **Referencias:**
/// - Backend: `src/models/comment.model.js`
@freezed
class CommentEntity with _$CommentEntity {
  const factory CommentEntity({
    /// ID único del comentario (UUID v4).
    required String id,

    /// ID del post al que pertenece.
    required String postId,

    /// ID del autor del comentario.
    required String userId,

    /// Nombre de usuario del autor (caché).
    required String username,

    /// Avatar del autor (caché).
    String? userAvatar,

    /// Texto del comentario.
    required String content,

    /// Contador de likes en este comentario.
    required int likesCount,

    /// Indica si el usuario actual dio like a este comentario.
    required bool isLiked,

    /// Fecha de creación.
    required DateTime createdAt,

    /// Fecha de última edición.
    required DateTime updatedAt,
  }) = _CommentEntity;

  const CommentEntity._();

  /// ⏱️ **Tiempo Transcurrido**
  ///
  /// Formato legible (ej: "2h ago").
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
