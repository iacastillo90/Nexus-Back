import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'verification_result_entity.freezed.dart';

/// 🛡️ **Estados de Verificación**
enum VerificationStatus {
  verified,
  suspicious,
  fake,
  unknown,
}

/// 🛡️ **Entidad de Resultado de Verificación**
///
/// Representa el análisis de autenticidad de un contenido (Post/Imagen).
/// Utiliza Content DNA y firmas criptográficas para detectar manipulaciones.
///
/// **Responsabilidades:**
/// - Informar si el contenido es original o manipulado (Deepfake).
/// - Mostrar el puntaje de confianza (Authenticity Score).
/// - Listar modificaciones detectadas.
///
/// **Referencias:**
/// - Backend: `src/services/verification.service.js`
@freezed
class VerificationResultEntity with _$VerificationResultEntity {
  const factory VerificationResultEntity({
    /// ID del contenido analizado.
    required String contentId,

    /// Hash único del contenido (Content DNA).
    required String contentDNA,

    /// Estado final del análisis.
    required VerificationStatus status,

    /// Puntuación de autenticidad (0-100).
    /// 100 = Totalmente original.
    required double authenticityScore,

    /// Fecha de verificación.
    required DateTime verifiedAt,

    /// Autor original detectado (si es un repost).
    String? originalAuthor,

    /// Fuente original (URL/Plataforma).
    String? originalSource,

    /// Fecha de publicación original.
    DateTime? originalDate,

    /// Lista de alteraciones detectadas (ej: "Face swap", "Audio noise").
    @Default([]) List<String> modifications,
  }) = _VerificationResultEntity;

  const VerificationResultEntity._();

  /// 🎨 **Color del Estado**
  Color getStatusColor() {
    switch (status) {
      case VerificationStatus.verified:
        return const Color(0xFF00FF85); // Green
      case VerificationStatus.suspicious:
        return const Color(0xFFFF9500); // Orange
      case VerificationStatus.fake:
        return const Color(0xFFFF4444); // Red
      case VerificationStatus.unknown:
        return const Color(0xFF666666); // Gray
    }
  }

  /// 🏷️ **Etiqueta del Estado**
  String getStatusLabel() {
    switch (status) {
      case VerificationStatus.verified:
        return 'Verified';
      case VerificationStatus.suspicious:
        return 'Suspicious';
      case VerificationStatus.fake:
        return 'Fake';
      case VerificationStatus.unknown:
        return 'Unknown';
    }
  }

  /// 🛡️ **Icono del Estado**
  IconData getStatusIcon() {
    switch (status) {
      case VerificationStatus.verified:
        return Icons.verified;
      case VerificationStatus.suspicious:
        return Icons.warning;
      case VerificationStatus.fake:
        return Icons.dangerous;
      case VerificationStatus.unknown:
        return Icons.help_outline;
    }
  }

  /// 📝 **Descripción de Autenticidad**
  String getAuthenticityDescription() {
    if (authenticityScore >= 90) {
      return 'Highly authentic content';
    } else if (authenticityScore >= 70) {
      return 'Likely authentic';
    } else if (authenticityScore >= 50) {
      return 'Authenticity uncertain';
    } else if (authenticityScore >= 30) {
      return 'Likely modified';
    } else {
      return 'Highly suspicious';
    }
  }

  /// 🧬 **Preview del DNA**
  ///
  /// Muestra los primeros 16 caracteres del hash para visualización técnica.
  String getDNAPreview() {
    if (contentDNA.length <= 16) return contentDNA;
    return '${contentDNA.substring(0, 16)}...';
  }
}
