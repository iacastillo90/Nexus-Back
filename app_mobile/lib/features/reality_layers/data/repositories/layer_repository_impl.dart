import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/reality_layer_entity.dart';
import '../../domain/entities/geo_post_entity.dart';
import '../../domain/repositories/layer_repository.dart';
import '../datasources/layer_datasource.dart';
import '../datasources/geo_post_datasource.dart';

/// Implementation of LayerRepository
class LayerRepositoryImpl implements LayerRepository {
  final LayerDataSource layerDataSource;
  final GeoPostDataSource geoPostDataSource;

  LayerRepositoryImpl({
    required this.layerDataSource,
    required this.geoPostDataSource,
  });

  @override
  Future<Either<Failure, List<RealityLayerEntity>>> getLayers() async {
    try {
      final layers = layerDataSource.getLayers();
      return Right(layers);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GeoPostEntity>>> getGeoPosts({
    required String layerId,
    required double latitude,
    required double longitude,
    required double radiusKm,
  }) async {
    try {
      final posts = await geoPostDataSource.getGeoPosts(
        layerId: layerId,
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
      );

      // Convert to entities and calculate distances
      final entities = posts.map((post) {
        final entity = post.toEntity();
        final distance = entity.calculateDistance(latitude, longitude);
        return entity.copyWith(distance: distance);
      }).toList();

      // Sort by distance (nearest first)
      entities.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

      return Right(entities);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GeoPostEntity>> createGeoPost({
    required String content,
    required String realityLayer,
    required double latitude,
    required double longitude,
    String? locationName,
    List<String>? mediaUrls,
  }) async {
    try {
      final post = await geoPostDataSource.createGeoPost(
        content: content,
        realityLayer: realityLayer,
        latitude: latitude,
        longitude: longitude,
        locationName: locationName,
        mediaUrls: mediaUrls,
      );

      return Right(post.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
