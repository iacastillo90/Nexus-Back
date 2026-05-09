import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'dream_entity.freezed.dart';

/// 🌙 **Estados del Sueño**
enum DreamStatus {
  active,
  completed,
  archived,
}

/// 🌙 **Entidad de Sueño (Dream)**
///
/// Representa una historia colaborativa creada por múltiples usuarios.
/// Funciona como un hilo narrativo donde cada participante añade un fragmento.
///
/// **Responsabilidades:**
/// - Gestionar el ciclo de vida de la historia (Activa -> Completada).
/// - Controlar el límite de contribuciones (slots).
/// - Agrupar las partes narrativas ([DreamContributionEntity]).
///
/// **Referencias:**
/// - Backend: `src/models/dream.model.js`
@freezed
class DreamEntity with _$DreamEntity {
  const factory DreamEntity({
    /// ID único del sueño.
    required String id,

    /// Título creativo de la historia.
    required String title,

    /// Premisa o semilla inicial.
    required String description,

    /// ID del creador original.
    required String creatorId,

    /// Nombre del creador (caché).
    required String creatorName,

    /// Avatar del creador (caché).
    String? creatorAvatar,

    /// Número máximo de partes permitidas.
    required int maxContributions,

    /// Número actual de partes escritas.
    required int currentContributions,

    /// Estado actual (Activo, Completado, Archivado).
    required DreamStatus status,

    /// Fecha de inicio.
    required DateTime createdAt,

    /// Fecha de finalización (cuando se llenaron los slots).
    DateTime? completedAt,

    /// Etiquetas temáticas (ej: "Sci-Fi", "Horror").
    @Default([]) List<String> tags,

    /// Contador de lecturas.
    @Default(0) int viewCount,

    /// Contador de likes totales.
    @Default(0) int likeCount,
  }) = _DreamEntity;

  const DreamEntity._();

  /// 📊 **Progreso de la Historia**
  ///
  /// Retorna un porcentaje (0.0 - 100.0) de completitud.
  double getProgress() {
    if (maxContributions == 0) return 0.0;
    return (currentContributions / maxContributions * 100).clamp(0.0, 100.0);
  }

  /// 🔒 **Está Lleno**
  ///
  /// Retorna `true` si ya no acepta más contribuciones.
  bool isFull() {
    return currentContributions >= maxContributions;
  }

  /// 🎨 **Color del Estado**
  Color getStatusColor() {
    switch (status) {
      case DreamStatus.active:
        return const Color(0xFF00FF85); // Green
      case DreamStatus.completed:
        return const Color(0xFFB026FF); // Purple
      case DreamStatus.archived:
        return const Color(0xFF666666); // Gray
    }
  }

  /// 🏷️ **Etiqueta del Estado**
  String getStatusLabel() {
    switch (status) {
      case DreamStatus.active:
        return 'Active';
      case DreamStatus.completed:
        return 'Completed';
      case DreamStatus.archived:
        return 'Archived';
    }
  }

  /// ⏳ **Texto de Tiempo Restante**
  ///
  /// Muestra cuántos espacios quedan disponibles.
  /// Ej: "3 slots left".
  String getTimeRemainingText() {
    if (status != DreamStatus.active) {
      return getStatusLabel();
    }

    final remaining = maxContributions - currentContributions;
    return '$remaining ${remaining == 1 ? 'slot' : 'slots'} left';
  }

  /// 👁️ **Vistas Formateadas**
  String getFormattedViewCount() {
    if (viewCount >= 1000000) {
      return '${(viewCount / 1000000).toStringAsFixed(1)}M views';
    } else if (viewCount >= 1000) {
      return '${(viewCount / 1000).toStringAsFixed(1)}K views';
    } else {
      return '$viewCount views';
    }
  }
}
