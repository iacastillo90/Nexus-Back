import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_entity.freezed.dart';

/// 🤖 **Entidad de Mentor IA**
///
/// Representa a un asistente virtual especializado (Persona) dentro del chat.
/// Cada mentor tiene una personalidad, especialidad y estilo visual único.
///
/// **Responsabilidades:**
/// - Definir la identidad del agente IA (Echo, Dr. Luma, Cipher, Aurora).
/// - Proveer metadatos visuales (color, icono) para la UI.
/// - Gestionar el estado de la conversación con la IA.
@freezed
class MentorEntity with _$MentorEntity {
  const factory MentorEntity({
    /// ID único del mentor (slug: 'echo', 'dr_luma', etc.).
    required String id,

    /// Nombre visible del mentor.
    required String name,

    /// Área de especialidad (ej: "Tecnología", "Ciencia", "Seguridad").
    required String specialty,

    /// URL o path del avatar.
    required String avatar,

    /// Descripción breve del rol del mentor.
    required String description,

    /// Prompt de sistema que define su tono y estilo de respuesta.
    required String personality,

    /// Lista de temas en los que es experto.
    @Default([]) List<String> expertise,

    /// Siempre true para IAs (siempre disponibles).
    @Default(true) bool isOnline,

    /// Mensajes no leídos de este mentor.
    @Default(0) int unreadCount,

    /// Último mensaje intercambiado.
    String? lastMessage,

    /// Fecha del último mensaje.
    DateTime? lastMessageTime,
  }) = _MentorEntity;

  const MentorEntity._();

  /// 🎨 **Color Hexadecimal**
  ///
  /// Devuelve el color temático asociado a la identidad del mentor.
  /// - Echo: Cyan (#00D9FF)
  /// - Dr. Luma: Purple (#B026FF)
  /// - Cipher: Green (#00FF85)
  /// - Aurora: Pink (#FF006E)
  String get colorHex {
    switch (id) {
      case 'echo':
        return '#00D9FF'; // Cyan
      case 'dr_luma':
        return '#B026FF'; // Purple
      case 'cipher':
        return '#00FF85'; // Green
      case 'aurora':
        return '#FF006E'; // Pink
      default:
        return '#00D9FF';
    }
  }

  /// 🎭 **Icono Representativo**
  ///
  /// Devuelve un emoji que resume la esencia del mentor.
  String get icon {
    switch (id) {
      case 'echo':
        return '🤖'; // AI/Tech
      case 'dr_luma':
        return '🧬'; // Science
      case 'cipher':
        return '🔐'; // Security
      case 'aurora':
        return '✨'; // Creativity
      default:
        return '🤖';
    }
  }

  /// ⏱️ **Tiempo Transcurrido**
  ///
  /// Formato corto de tiempo para la lista de chats.
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

  /// 📩 **Tiene No Leídos**
  bool get hasUnread => unreadCount > 0;
}
