import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:math' show asin, cos, sqrt, sin, atan2;

part 'geo_post_entity.freezed.dart';

/// 📍 **Entidad de Post Geo-Localizado**
///
/// Extensión de un post normal que incluye coordenadas GPS.
/// Se utiliza en la vista de Mapa de Realidad Aumentada.
///
/// **Responsabilidades:**
/// - Almacenar latitud/longitud.
/// - Calcular distancias relativas al usuario (Fórmula Haversine).
/// - Vincular contenido digital con ubicaciones físicas.
///
/// **Referencias:**
/// - Backend: `src/models/geo_post.model.js` (MongoDB GeoJSON).
@freezed
class GeoPostEntity with _$GeoPostEntity {
  const factory GeoPostEntity({
    /// ID único del post.
    required String id,

    /// ID del autor.
    required String authorId,

    /// Nombre del autor.
    required String authorName,

    /// Avatar del autor.
    String? authorAvatar,

    /// Contenido del mensaje.
    required String content,

    /// Multimedia adjunta.
    List<String>? mediaUrls,

    /// Capa de realidad a la que pertenece.
    required String realityLayer,

    /// Latitud geográfica.
    required double latitude,

    /// Longitud geográfica.
    required double longitude,

    /// Nombre legible del lugar (Reverse Geocoding).
    String? locationName,

    /// Fecha de creación.
    required DateTime createdAt,

    /// Likes.
    @Default(0) int likeCount,

    /// Comentarios.
    @Default(0) int commentCount,

    /// Si el usuario le dio like.
    @Default(false) bool isLiked,

    /// Distancia calculada desde el usuario (en km).
    double? distance,
  }) = _GeoPostEntity;

  const GeoPostEntity._();

  /// 📏 **Calcular Distancia (Haversine)**
  ///
  /// Calcula la distancia en kilómetros entre el post y el usuario.
  ///
  /// **Parámetros:**
  /// - [userLat]: Latitud del usuario.
  /// - [userLng]: Longitud del usuario.
  double calculateDistance(double userLat, double userLng) {
    const R = 6371; // Radio de la Tierra en km
    final dLat = _toRadians(latitude - userLat);
    final dLon = _toRadians(longitude - userLng);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(userLat)) *
            cos(_toRadians(latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distancia en km
  }

  double _toRadians(double degrees) {
    return degrees * (3.141592653589793 / 180.0);
  }

  /// 🎯 **Está Cerca**
  ///
  /// Retorna `true` si el post está dentro del radio especificado.
  bool isNearby(double userLat, double userLng, double radiusKm) {
    return calculateDistance(userLat, userLng) <= radiusKm;
  }

  /// 🏷️ **Texto de Distancia**
  ///
  /// Formato legible (ej: "500m away", "2.5km away").
  String getDistanceString(double userLat, double userLng) {
    final dist = calculateDistance(userLat, userLng);
    if (dist < 1) {
      return '${(dist * 1000).round()}m away';
    } else {
      return '${dist.toStringAsFixed(1)}km away';
    }
  }
}
