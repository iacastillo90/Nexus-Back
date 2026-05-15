import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'notification_entity.freezed.dart';

/// 🔔 **Tipos de Notificación**
enum NotificationType {
  like,
  comment,
  follow,
  mention,
  system,
}

/// 🔔 **Entidad de Notificación**
///
/// Representa una alerta para el usuario sobre interacciones relevantes.
///
/// **Responsabilidades:**
/// - Informar sobre nuevos likes, comentarios o seguidores.
/// - Vincular al actor (quien genera la acción) con el objetivo (post/perfil).
/// - Proveer lógica visual (iconos, colores) para la lista de notificaciones.
///
/// **Referencias:**
/// - Backend: `src/models/notification.model.js`
@freezed
class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    /// ID único de la notificación.
    required String id,

    /// ID del usuario destinatario.
    required String userId,

    /// Tipo de evento (like, comment, follow...).
    required NotificationType type,

    /// Título corto (ej: "Nuevo seguidor").
    required String title,

    /// Mensaje descriptivo (ej: "@usuario te ha seguido").
    required String message,

    /// ID del usuario que generó la acción (Actor).
    String? actorId,

    /// Nombre del actor (caché).
    String? actorName,

    /// Avatar del actor (caché).
    String? actorAvatar,

    /// ID del objeto afectado (Post ID, Comment ID).
    String? targetId,

    /// Fecha de creación.
    required DateTime createdAt,

    /// Indica si ya fue vista por el usuario.
    @Default(false) bool isRead,
  }) = _NotificationEntity;

  const NotificationEntity._();

  /// 🎭 **Icono del Tipo**
  IconData getIcon() {
    switch (type) {
      case NotificationType.like:
        return Icons.favorite;
      case NotificationType.comment:
        return Icons.comment;
      case NotificationType.follow:
        return Icons.person_add;
      case NotificationType.mention:
        return Icons.alternate_email;
      case NotificationType.system:
        return Icons.notifications;
    }
  }

  /// 🎨 **Color del Tipo**
  Color getColor() {
    switch (type) {
      case NotificationType.like:
        return const Color(0xFFFF006E); // Pink
      case NotificationType.comment:
        return const Color(0xFF00D9FF); // Cyan
      case NotificationType.follow:
        return const Color(0xFF00FF85); // Green
      case NotificationType.mention:
        return const Color(0xFFB026FF); // Purple
      case NotificationType.system:
        return const Color(0xFFFF9500); // Orange
    }
  }

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

  /// 🏷️ **Etiqueta del Tipo**
  String getTypeLabel() {
    switch (type) {
      case NotificationType.like:
        return 'Like';
      case NotificationType.comment:
        return 'Comment';
      case NotificationType.follow:
        return 'Follow';
      case NotificationType.mention:
        return 'Mention';
      case NotificationType.system:
        return 'System';
    }
  }
}
