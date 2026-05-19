import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_entity.freezed.dart';

/// 🏅 **Entidad de Insignia (Badge)**
///
/// Representa un logro desbloqueado por el usuario.
/// Las insignias son recompensas visuales por hitos específicos.
///
/// **Responsabilidades:**
/// - Mostrar logros en el perfil.
/// - Categorizar logros (Karma, Contenido, Comunidad).
/// - Indicar rareza y nivel.
@freezed
class BadgeEntity with _$BadgeEntity {
  const factory BadgeEntity({
    /// ID único de la insignia.
    required String id,

    /// Nombre visible del logro.
    required String name,

    /// Descripción de cómo se obtuvo.
    required String description,

    /// URL del icono visual.
    required String iconUrl,

    /// Categoría del logro.
    /// Valores: 'karma', 'content', 'community', 'special'.
    required String category,

    /// Fecha de obtención.
    required DateTime earnedAt,

    /// Nivel de la insignia (1=Bronce, 2=Plata, 3=Oro).
    int? level,

    /// Indica si es una insignia de evento limitado o difícil de conseguir.
    bool? isRare,
  }) = _BadgeEntity;

  const BadgeEntity._();

  /// ✨ **Rareza (Display)**
  ///
  /// Texto descriptivo de la rareza basado en nivel y flag `isRare`.
  String get rarityDisplay {
    if (isRare == true) return 'Rare';
    if (level != null && level! >= 3) return 'Epic';
    if (level != null && level! >= 2) return 'Uncommon';
    return 'Common';
  }
}
