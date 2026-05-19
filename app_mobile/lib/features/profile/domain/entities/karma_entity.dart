import 'package:freezed_annotation/freezed_annotation.dart';

part 'karma_entity.freezed.dart';

/// ⚖️ **Entidad de Karma**
///
/// Representa la reputación y contribución de un usuario en la plataforma.
/// El sistema de Karma gamifica la interacción positiva y penaliza el comportamiento tóxico.
///
/// **Responsabilidades:**
/// - Desglosar el puntaje total en categorías (autenticidad, comunidad, etc.).
/// - Definir el nivel (Tier) y progreso del usuario.
/// - Proveer lógica de visualización (colores, rangos).
///
/// **Referencias:**
/// - Backend: `src/services/karma.service.js`
@freezed
class KarmaEntity with _$KarmaEntity {
  const factory KarmaEntity({
    /// Puntuación total acumulada (0 - 1000+).
    required int totalScore,

    /// Puntuación por ser real y verificar identidad.
    required int authenticityScore,

    /// Puntuación por crear contenido de valor.
    required int contributionScore,

    /// Puntuación por ayudar a otros y comentar positivamente.
    required int communityScore,

    /// Puntuación por actividad regular.
    required int consistencyScore,

    /// Nivel actual.
    /// Valores: 'newcomer', 'established', 'verified', 'legendary', 'suspicious'.
    required String tier,

    /// Progreso hacia el siguiente nivel (0.0 - 1.0).
    required double tierProgress,

    /// Privilegios desbloqueados basados en el Tier.
    required List<String> privileges,

    /// Ranking global (opcional).
    int? rank,

    /// Cambio semanal en puntos (opcional).
    int? weeklyChange,
  }) = _KarmaEntity;

  const KarmaEntity._();

  ///
  /// Asigna un color semántico según el nivel de reputación.
  String get tierColor {
    switch (tier.toLowerCase()) {
      case 'legendary':
        return 'gold';
      case 'verified':
        return 'green';
      case 'established':
        return 'blue';
      case 'newcomer':
        return 'purple';
      case 'suspicious':
        return 'red';
      default:
        return 'grey';
    }
  }

  /// 📊 **Porcentaje de Karma**
  ///
  /// Normaliza el score a un valor 0.0-1.0 para barras de progreso.
  /// Asume un cap suave de 1000 puntos.
  double get karmaPercentage {
    return (totalScore / 1000).clamp(0.0, 1.0);
  }

  /// 🏷️ **Nombre del Tier (Display)**
  String get tierDisplayName {
    return tier[0].toUpperCase() + tier.substring(1);
  }

  /// ✅ **Es Verificado**
  ///
  /// Retorna `true` si el usuario tiene un nivel de confianza alto.
  bool get isVerified => tier == 'verified' || tier == 'legendary';
}
