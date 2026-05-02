import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';

/// 💬 **Entidad de Mensaje (Message)**
///
/// Representa una unidad de comunicación dentro de un chat.
/// Soporta múltiples tipos de contenido y estados de entrega (Offline-First).
///
/// **Responsabilidades:**
/// - Transportar el contenido del mensaje (texto, imagen, audio).
/// - Rastrear el estado de entrega (enviando, enviado, leído).
/// - Identificar al remitente y la conversación a la que pertenece.
///
/// **Referencias:**
/// - Backend: `src/models/message.model.js`
/// - Base de Datos Local: `lib/core/local/schemas/message_schema.dart`
@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    /// ID único del mensaje (UUID v4).
    required String id,

    /// ID de la conversación a la que pertenece.
    required String conversationId,

    /// ID del usuario que envió el mensaje.
    required String senderId,

    /// Nombre del remitente (caché).
    required String senderName,

    /// Avatar del remitente (caché).
    String? senderAvatar,

    /// Contenido del mensaje (payload).
    required String content,

    /// Tipo de mensaje.
    /// Valores: 'text', 'image', 'audio'.
    @Default('text') String type,

    /// Marca de tiempo de creación.
    required DateTime timestamp,

    /// Indica si el destinatario ha leído el mensaje.
    @Default(false) bool isRead,

    /// Indica si el mensaje ha sido confirmado por el servidor.
    /// Si es `false`, el mensaje está pendiente de sincronización (Offline).
    @Default(true) bool isSent,

    /// Indica si el mensaje se está enviando actualmente (UI optimista).
    @Default(false) bool isSending,
  }) = _MessageEntity;

  const MessageEntity._();

  /// ⏱️ **Tiempo Transcurrido (Time Ago)**
  ///
  /// Devuelve una representación textual del tiempo relativo.
  /// Formatos: "Just now", "5m ago", "2h ago", "5d ago", "DD/MM/YYYY".
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  /// 👤 **Es Propio**
  ///
  /// Retorna `true` si el mensaje fue enviado por el usuario actual.
  /// Útil para alinear burbujas de chat (derecha/izquierda).
  ///
  /// **Parámetros:**
  /// - [currentUserId]: ID del usuario logueado.
  bool isOwn(String currentUserId) => senderId == currentUserId;

  /// 🚦 **Icono de Estado**
  ///
  /// Devuelve un símbolo visual del estado del mensaje.
  /// - ⏰: Enviando / Pendiente (Offline).
  /// - ✓: Enviado al servidor.
  /// - ✓✓: Leído por el destinatario.
  String get statusIcon {
    if (isSending) return '⏰'; // Clock
    if (!isSent) return '⏰';
    if (isRead) return '✓✓'; // Double check
    return '✓'; // Single check
  }

  /// ⌚ **Hora Formateada**
  ///
  /// Devuelve la hora del mensaje en formato HH:MM (24h).
  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
