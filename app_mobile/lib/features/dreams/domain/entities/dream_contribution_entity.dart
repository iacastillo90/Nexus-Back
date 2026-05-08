import 'package:freezed_annotation/freezed_annotation.dart';

part 'dream_contribution_entity.freezed.dart';

/// ✍️ **Entidad de Contribución de Sueño**
///
/// Representa un fragmento narrativo (párrafo/capítulo) añadido a un Sueño.
///
/// **Responsabilidades:**
/// - Almacenar el texto de la continuación de la historia.
/// - Mantener el orden secuencial de la narrativa.
/// - Vincular al autor con el sueño padre.
@freezed
class DreamContributionEntity with _$DreamContributionEntity {
  const factory DreamContributionEntity({
    /// ID único de la contribución.
    required String id,

    /// ID del sueño al que pertenece.
    required String dreamId,

    /// ID del autor.
    required String userId,

    /// Nombre del autor (caché).
    required String userName,

    /// Avatar del autor (caché).
    String? userAvatar,

    /// Texto narrativo.
    required String content,

    /// Posición en la secuencia (1, 2, 3...).
    required int order,

    /// Fecha de creación.
    required DateTime createdAt,

    /// Contador de likes locales.
    @Default(0) int likeCount,

    /// Si el usuario actual le dio like.
    @Default(false) bool isLiked,
  }) = _DreamContributionEntity;

  const DreamContributionEntity._();

  /// ⏱️ **Tiempo Transcurrido**
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${(difference.inDays / 7).floor()}w ago';
    }
  }

  /// 🔢 **Etiqueta de Orden**
  ///
  /// Ej: "Part 1", "Part 5".
  String getOrderLabel() {
    return 'Part $order';
  }
}
