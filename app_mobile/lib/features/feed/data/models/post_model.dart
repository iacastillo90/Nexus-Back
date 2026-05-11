import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post_entity.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

// Force rebuild 3

/// 📰 **Modelo de Publicación (DTO)**
///
/// Representación JSON de un post en la API.
///
/// **Responsabilidades:**
/// - Serialización JSON <-> Objeto.
/// - Transformación a [PostEntity] (Dominio).
///
/// **Referencias:**
/// - Backend: `src/models/post.model.js`
@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    /// ID único del post.
    required String id,

    /// ID del autor.
    required String userId,

    /// Nombre de usuario del autor.
    String? username,

    /// Avatar del autor.
    String? userAvatar,

    /// Contenido textual.
    required String content,

    /// URLs de archivos adjuntos.
    List<String>? mediaUrls,

    /// Tipo de media ('image', 'video').
    String? mediaType,

    /// Contador de likes.
    @Default(0) int likesCount,

    /// Contador de comentarios.
    @Default(0) int commentsCount,

    /// Contador de compartidos.
    @Default(0) int sharesCount,

    /// Si el usuario actual dio like.
    @Default(false) bool isLiked,

    /// Si el usuario actual guardó el post.
    @Default(false) bool isBookmarked,

    /// Hash de verificación de contenido (Content DNA).
    String? contentDNA,

    /// Capa de realidad (Tech, Art, etc.).
    String? realityLayer,

    /// Metadatos flexibles.
    Map<String, dynamic>? metadata,

    /// Fecha de creación.
    required DateTime createdAt,

    /// Fecha de actualización.
    required DateTime updatedAt,
  }) = _PostModel;

  const PostModel._();

  /// 📥 **Desde JSON**
  // Force rebuild
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  /// 🔄 **A Entidad de Dominio**
  PostEntity toEntity() {
    return PostEntity(
      id: id,
      userId: userId,
      username: username,
      userAvatar: userAvatar,
      content: content,
      mediaUrls: mediaUrls,
      mediaType: mediaType,
      likesCount: likesCount,
      commentsCount: commentsCount,
      sharesCount: sharesCount,
      isLiked: isLiked,
      isBookmarked: isBookmarked,
      contentDNA: contentDNA,
      realityLayer: realityLayer,
      metadata: metadata,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
