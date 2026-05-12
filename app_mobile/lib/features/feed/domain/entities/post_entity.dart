import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';

/// 📰 **Entidad de Publicación (Post)**
///
/// Representa una unidad de contenido en el Feed de Nexus.
/// Puede contener texto, multimedia y metadatos avanzados (Content DNA).
///
/// **Responsabilidades:**
/// - Almacenar el contenido generado por el usuario.
/// - Rastrear métricas de interacción (likes, comentarios, shares).
/// - Mantener la integridad del contenido mediante [contentDNA].
/// - Clasificar el contenido en capas de realidad ([realityLayer]).
///
/// **Referencias:**
/// - Backend: `src/models/post.model.js`
/// - Base de Datos Local: `lib/core/local/schemas/post_schema.dart`
@freezed
class PostEntity with _$PostEntity {
  const factory PostEntity({
    /// ID único de la publicación (UUID v4).
    required String id,

    /// ID del autor de la publicación.
    required String userId,

    /// Nombre de usuario del autor (caché para evitar joins costosos).
    String? username,

    /// URL del avatar del autor (caché).
    String? userAvatar,

    /// Contenido textual de la publicación.
    required String content,

    /// Lista de URLs de archivos multimedia adjuntos (imágenes, videos).
    List<String>? mediaUrls,

    /// Tipo de multimedia principal.
    /// Valores: 'image', 'video', 'audio', o null si es solo texto.
    String? mediaType,

    /// Contador total de "Me gusta".
    required int likesCount,

    /// Contador total de comentarios.
    required int commentsCount,

    /// Contador total de veces compartido.
    required int sharesCount,

    /// Indica si el usuario actual ha dado like a este post.
    required bool isLiked,

    /// Indica si el usuario actual ha guardado este post.
    required bool isBookmarked,

    /// 🧬 **Content DNA**
    /// Hash criptográfico único que garantiza la autenticidad y origen del contenido.
    /// Se usa para prevenir deepfakes y verificar la autoría.
    String? contentDNA,

    /// 🌐 **Capa de Realidad**
    /// Define en qué plano existe este contenido.
    /// - 'physical': Fotos/Videos del mundo real.
    /// - 'digital': Arte digital, capturas de pantalla, código.
    /// - 'hybrid': Realidad Aumentada (AR) o contenido mixto.
    String? realityLayer,

    /// Metadatos adicionales flexibles (ej: ubicación, etiquetas IA).
    Map<String, dynamic>? metadata,

    /// Fecha de publicación original.
    required DateTime createdAt,

    /// Fecha de última edición.
    required DateTime updatedAt,
  }) = _PostEntity;

  const PostEntity._();

  /// 🖼️ **Tiene Multimedia**
  ///
  /// Retorna `true` si el post contiene al menos un archivo adjunto.
  bool get hasMedia => mediaUrls != null && mediaUrls!.isNotEmpty;

  /// 📷 **Tiene Imágenes**
  ///
  /// Retorna `true` si el contenido multimedia es de tipo imagen.
  bool get hasImages => mediaType == 'image' && hasMedia;

  /// 🎥 **Tiene Video**
  ///
  /// Retorna `true` si el contenido multimedia es de tipo video.
  bool get hasVideo => mediaType == 'video' && hasMedia;

  /// ⏱️ **Tiempo Transcurrido (Time Ago)**
  ///
  /// Devuelve una cadena legible indicando cuánto tiempo ha pasado desde la publicación.
  /// Ejemplos: "Just now", "5m ago", "2h ago", "3d ago".
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

  /// 📊 **Formatear Contadores**
  ///
  /// Convierte números grandes en formato compacto (K/M).
  /// - 1200 -> "1.2K"
  /// - 1500000 -> "1.5M"
  ///
  /// **Parámetros:**
  /// - [count]: El número entero a formatear.
  static String formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}
