import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_entity.freezed.dart';

/// 🗨️ **Entidad de Conversación (Chat List Item)**
///
/// Representa un resumen de una conversación en la lista de chats.
/// Contiene datos del participante y el último mensaje para la vista previa.
///
/// **Responsabilidades:**
/// - Mostrar la lista de chats recientes.
/// - Indicar estados de presencia (online, escribiendo).
/// - Gestionar contadores de no leídos.
///
/// **Referencias:**
/// - Backend: `src/models/conversation.model.js`
@freezed
class ConversationEntity with _$ConversationEntity {
  const factory ConversationEntity({
    /// ID único de la conversación (UUID v4).
    required String id,

    /// ID del otro participante (usuario con quien se habla).
    required String participantId,

    /// Nombre del participante (caché).
    required String participantName,

    /// Avatar del participante (caché).
    String? participantAvatar,

    /// Contenido del último mensaje (para vista previa).
    String? lastMessage,

    /// Fecha del último mensaje (para ordenamiento).
    DateTime? lastMessageTime,

    /// Cantidad de mensajes no leídos en esta conversación.
    @Default(0) int unreadCount,

    /// Indica si el participante está conectado actualmente.
    @Default(false) bool isOnline,

    /// Indica si el participante está escribiendo...
    @Default(false) bool isTyping,

    /// Fecha de última conexión del participante.
    DateTime? lastSeen,
  }) = _ConversationEntity;

  const ConversationEntity._();

  /// ⏱️ **Tiempo Transcurrido (Time Ago)**
  ///
  /// Devuelve una cadena corta indicando cuándo fue el último mensaje.
  /// Formatos: "Just now", "5m", "2h", "5d", "DD/MM".
  String get timeAgo {
    if (lastMessageTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(lastMessageTime!);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${lastMessageTime!.day}/${lastMessageTime!.month}';
    }
  }

  /// 🟢 **Texto de Estado**
  ///
  /// Devuelve una descripción textual del estado del usuario.
  /// - "typing..."
  /// - "online"
  /// - "last seen X ago"
  /// - "offline"
  String get statusText {
    if (isTyping) return 'typing...';
    if (isOnline) return 'online';
    if (lastSeen != null) {
      final now = DateTime.now();
      final difference = now.difference(lastSeen!);

      if (difference.inMinutes < 60) {
        return 'last seen ${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return 'last seen ${difference.inHours}h ago';
      } else {
        return 'last seen ${difference.inDays}d ago';
      }
    }
    return 'offline';
  }

  /// 📩 **Tiene No Leídos**
  ///
  /// Retorna `true` si hay mensajes pendientes de leer.
  bool get hasUnread => unreadCount > 0;
}
