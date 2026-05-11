import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/comment_entity.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

/// 💬 **Modelo de Comentario (DTO)**
///
/// Representación JSON de un comentario en la API.
///
/// **Responsabilidades:**
/// - Serialización JSON <-> Objeto.
/// - Transformación a [CommentEntity] (Dominio).
///
/// **Referencias:**
/// - Backend: `src/models/comment.model.js`
@freezed
class CommentModel with _$CommentModel {
  const factory CommentModel({
    /// ID único del comentario.
    required String id,

    /// ID del post padre.
    required String postId,

    /// ID del autor.
    required String userId,

    /// Nombre de usuario del autor.
    required String username,

    /// Avatar del autor.
    String? userAvatar,

    /// Contenido textual.
    required String content,

    /// Contador de likes.
    required int likesCount,

    /// Si el usuario actual dio like.
    required bool isLiked,

    /// Fecha de creación.
    required DateTime createdAt,

    /// Fecha de actualización.
    required DateTime updatedAt,
  }) = _CommentModel;

  const CommentModel._();

  /// 📥 **Desde JSON**
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  /// 🔄 **A Entidad de Dominio**
  CommentEntity toEntity() {
    return CommentEntity(
      id: id,
      postId: postId,
      userId: userId,
      username: username,
      userAvatar: userAvatar,
      content: content,
      likesCount: likesCount,
      isLiked: isLiked,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
