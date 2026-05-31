import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'vibes_entity.freezed.dart';

/// 🌊 **Entidad de Vibes (Análisis de Sentimiento)**
///
/// Representa el estado emocional de un usuario basado en su actividad reciente.
/// Calculado por la IA (Local o Remota) analizando textos y patrones.
///
/// **Responsabilidades:**
/// - Cuantificar el "Vibe Score" (Energía positiva/negativa).
/// - Desglosar emociones específicas (Alegría, Ira, Tristeza, etc.).
/// - Proveer utilidades visuales (colores, iconos) para la UI.
///
/// **Referencias:**
/// - Servicio: `lib/core/services/local_ai_service.dart`
@freezed
class VibesEntity with _$VibesEntity {
  const factory VibesEntity({
    /// ID del usuario analizado.
    required String userId,

    /// Puntuación general de vibra (0-100).
    /// Altas puntuaciones indican positividad/energía.
    required double vibeScore,

    /// Mapa de emociones detectadas y su intensidad (0.0 - 1.0).
    /// Keys: 'joy', 'anger', 'sadness', 'fear', 'surprise'.
    required Map<String, double> emotions,

    /// Fecha del análisis.
    required DateTime timestamp,
  }) = _VibesEntity;

  const VibesEntity._();

  /// 📈 **Obtener Intensidad de Emoción**
  double getEmotion(String emotion) {
    return emotions[emotion] ?? 0.0;
  }

  /// 🏆 **Emoción Dominante**
  ///
  /// Retorna la emoción con mayor intensidad.
  String getDominantEmotion() {
    if (emotions.isEmpty) return 'neutral';

    String dominant = emotions.keys.first;
    double maxValue = emotions.values.first;

    for (final entry in emotions.entries) {
      if (entry.value > maxValue) {
        maxValue = entry.value;
        dominant = entry.key;
      }
    }

    return dominant;
  }

  /// 🎨 **Color de Emoción**
  ///
  /// Mapea emociones a colores de la teoría del color (Plutchik simplificado).
  Color getEmotionColor(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'joy':
        return const Color(0xFFFFD700); // Yellow
      case 'anger':
        return const Color(0xFFFF4444); // Red
      case 'sadness':
        return const Color(0xFF4A90E2); // Blue
      case 'fear':
        return const Color(0xFF9B59B6); // Purple
      case 'surprise':
        return const Color(0xFFFF9500); // Orange
      default:
        return const Color(0xFF00D9FF); // Cyan (default)
    }
  }

  /// 🎭 **Icono de Emoción**
  IconData getEmotionIcon(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'joy':
        return Icons.sentiment_very_satisfied;
      case 'anger':
        return Icons.sentiment_very_dissatisfied;
      case 'sadness':
        return Icons.sentiment_dissatisfied;
      case 'fear':
        return Icons.sentiment_neutral;
      case 'surprise':
        return Icons.sentiment_satisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  /// 🔮 **Interpretación del Vibe**
  ///
  /// Texto amigable para el usuario basado en el score global.
  String getVibeScoreInterpretation() {
    if (vibeScore >= 80) {
      return 'Excellent vibes! 🌟';
    } else if (vibeScore >= 60) {
      return 'Good energy ✨';
    } else if (vibeScore >= 40) {
      return 'Balanced mood ⚖️';
    } else if (vibeScore >= 20) {
      return 'Low energy 🌙';
    } else {
      return 'Need support 💙';
    }
  }

  /// 🌈 **Gradiente del Vibe**
  ///
  /// Retorna un par de colores para fondos degradados según el score.
  List<Color> getVibeScoreGradient() {
    if (vibeScore >= 80) {
      return [const Color(0xFF00FF85), const Color(0xFF00D9FF)]; // Green to Cyan
    } else if (vibeScore >= 60) {
      return [const Color(0xFF00D9FF), const Color(0xFFB026FF)]; // Cyan to Purple
    } else if (vibeScore >= 40) {
      return [const Color(0xFFB026FF), const Color(0xFFFF9500)]; // Purple to Orange
    } else if (vibeScore >= 20) {
      return [const Color(0xFFFF9500), const Color(0xFFFF006E)]; // Orange to Pink
    } else {
      return [const Color(0xFFFF006E), const Color(0xFFFF4444)]; // Pink to Red
    }
  }
}
