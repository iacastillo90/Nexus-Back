import 'package:freezed_annotation/freezed_annotation.dart';
import 'karma_entity.dart';
import 'badge_entity.dart';

part 'profile_entity.freezed.dart';

/// 👤 **Entidad de Perfil Completo**
///
/// Agrega toda la información pública de un usuario para mostrar en su página de perfil.
/// Combina datos básicos, estadísticas sociales, karma e insignias.
///
/// **Responsabilidades:**
/// - Centralizar la vista "pública" de un usuario.
/// - Calcular métricas derivadas (miembro desde, iniciales).
/// - Servir como DTO para la pantalla `ProfileScreen`.
///
/// **Referencias:**
/// - Backend: `src/controllers/profile.controller.js` (getProfile).
@freezed
class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    /// ID del usuario.
    required String id,

    /// Handle único (@username).
    required String username,

    /// Email (puede estar ofuscado si no es el propio usuario).
    required String email,

    /// URL del avatar.
    String? avatar,

    /// URL de la imagen de portada.
    String? coverImage,

    /// Biografía corta.
    String? bio,

    /// Ubicación (Ciudad, País).
    String? location,

    /// Enlace externo.
    String? website,

    /// Cantidad de seguidores.
    required int followersCount,

    /// Cantidad de seguidos.
    required int followingCount,

    /// Cantidad de publicaciones.
    required int postsCount,

    /// Puntuación detallada de Karma.
    required KarmaEntity karma,

    /// Lista de insignias ganadas.
    List<BadgeEntity>? badges,

    /// Fecha de registro.
    required DateTime createdAt,

    /// Indica si el usuario actual sigue a este perfil.
    bool? isFollowing,

    /// Indica si es un usuario Premium.
    bool? isPremium,
  }) = _ProfileEntity;

  const ProfileEntity._();

  /// 🏷️ **Nombre para Mostrar**
  String get displayName => username;

  /// 🔤 **Iniciales**
  ///
  /// Genera iniciales basadas en el username (ej: "Nexus User" -> "NU").
  String get initials {
    if (username.isEmpty) return '??';
    final parts = username.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return username.substring(0, username.length >= 2 ? 2 : 1).toUpperCase();
  }

  /// 📅 **Miembro Desde**
  ///
  /// Texto amigable indicando la antigüedad de la cuenta.
  String get memberSince {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months';
    } else {
      return '${difference.inDays} days';
    }
  }
}
