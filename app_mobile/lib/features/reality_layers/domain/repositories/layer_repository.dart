import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/reality_layer_entity.dart';
import '../entities/geo_post_entity.dart';

/// Layer repository interface
abstract class LayerRepository {
  /// Get all available reality layers
  Future<Either<Failure, List<RealityLayerEntity>>> getLayers();

  /// Get geo-posts near location
  Future<Either<Failure, List<GeoPostEntity>>> getGeoPosts({
    required String layerId,
    required double latitude,
    required double longitude,
    required double radiusKm,
  });

  /// Create geo-post with location
  Future<Either<Failure, GeoPostEntity>> createGeoPost({
    required String content,
    required String realityLayer,
    required double latitude,
    required double longitude,
    String? locationName,
    List<String>? mediaUrls,
  });
}
