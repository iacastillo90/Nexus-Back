import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'reality_layer_entity.freezed.dart';

/// 🌐 **Entidad de Capa de Realidad (Reality Layer)**
///
/// Representa un filtro temático o dimensión de contenido en Nexus.
/// Permite a los usuarios explorar diferentes "versiones" del feed.
///
/// **Responsabilidades:**
/// - Definir temas como "Tech", "Art", "Underground".
/// - Proveer identidad visual (iconos, gradientes) para la UI.
/// - Filtrar contenido geo-localizado.
@freezed
class RealityLayerEntity with _$RealityLayerEntity {
  const factory RealityLayerEntity({
    /// ID único de la capa (slug: 'tech', 'art').
    required String id,

    /// Nombre visible.
    required String name,

    /// Descripción de la temática.
    required String description,

    /// Nombre del icono (string para mapeo).
    required String icon,

    /// Color base en Hex.
    required String colorHex,

    /// Cantidad de posts activos en esta capa.
    @Default(0) int postCount,
  }) = _RealityLayerEntity;

  const RealityLayerEntity._();

  /// 🎨 **Obtener Color**
  Color getColor() {
    return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
  }

  /// 🌈 **Obtener Gradiente**
  ///
  /// Genera un gradiente suave basado en el color base.
  List<Color> getGradient() {
    final baseColor = getColor();
    return [
      baseColor,
      baseColor.withValues(alpha: 0.6),
    ];
  }

  /// 🎭 **Obtener Icono Material**
  IconData getIconData() {
    switch (id) {
      case 'tech':
        return Icons.developer_board;
      case 'art':
        return Icons.palette;
      case 'science':
        return Icons.science;
      case 'underground':
        return Icons.lock;
      case 'social':
        return Icons.people;
      default:
        return Icons.layers;
    }
  }
}
