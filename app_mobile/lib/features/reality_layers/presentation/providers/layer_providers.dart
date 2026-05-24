import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nexus_mobile/core/network/dio_provider.dart';
import '../../data/datasources/layer_datasource.dart';
import '../../data/datasources/geo_post_datasource.dart';
import '../../data/datasources/location_datasource.dart';
import '../../data/repositories/layer_repository_impl.dart';
import '../../domain/repositories/layer_repository.dart';
import '../../domain/entities/reality_layer_entity.dart';
import '../../domain/entities/geo_post_entity.dart';

part 'layer_providers.g.dart';

/// Layer datasource provider
@riverpod
LayerDataSource layerDataSource(LayerDataSourceRef ref) {
  return LayerDataSource();
}

/// Geo post datasource provider
@riverpod
GeoPostDataSource geoPostDataSource(GeoPostDataSourceRef ref) {
  return GeoPostDataSource(ref.watch(networkDioProvider));
}

/// Location datasource provider
@riverpod
LocationDataSource locationDataSource(LocationDataSourceRef ref) {
  return LocationDataSource();
}

/// Layer repository provider
@riverpod
LayerRepository layerRepository(LayerRepositoryRef ref) {
  return LayerRepositoryImpl(
    layerDataSource: ref.watch(layerDataSourceProvider),
    geoPostDataSource: ref.watch(geoPostDataSourceProvider),
  );
}

/// Reality layers provider
@riverpod
class RealityLayers extends _$RealityLayers {
  @override
  List<RealityLayerEntity> build() {
    return ref.watch(layerDataSourceProvider).getLayers();
  }
}

/// Selected layer provider
@riverpod
class SelectedLayer extends _$SelectedLayer {
  @override
  String? build() {
    return null; // null = all layers
  }

  void selectLayer(String? layerId) {
    state = layerId;
  }
}

/// Map radius provider (in km)
@riverpod
class MapRadius extends _$MapRadius {
  @override
  double build() {
    return 5.0; // Default 5km
  }

  void setRadius(double radiusKm) {
    state = radiusKm;
  }
}

/// User location provider
@riverpod
class UserLocation extends _$UserLocation {
  @override
  Future<Position> build() async {
    return await ref.read(locationDataSourceProvider).getCurrentLocation();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(locationDataSourceProvider).getCurrentLocation(),
    );
  }
}

/// Geo posts controller
@riverpod
class GeoPosts extends _$GeoPosts {
  @override
  Future<List<GeoPostEntity>> build() async {
    final selectedLayer = ref.watch(selectedLayerProvider);
    final radius = ref.watch(mapRadiusProvider);
    final locationState = ref.watch(userLocationProvider);

    return locationState.when(
      data: (position) => _loadPosts(
        selectedLayer ?? 'all',
        position.latitude,
        position.longitude,
        radius,
      ),
      loading: () => [],
      error: (_, __) => [],
    );
  }

  Future<List<GeoPostEntity>> _loadPosts(
    String layerId,
    double lat,
    double lng,
    double radius,
  ) async {
    if (layerId == 'all') {
      // Load posts from all layers
      final layers = ref.read(realityLayersProvider);
      final allPosts = <GeoPostEntity>[];

      for (final layer in layers) {
        final result = await ref.read(layerRepositoryProvider).getGeoPosts(
              layerId: layer.id,
              latitude: lat,
              longitude: lng,
              radiusKm: radius,
            );

        result.fold(
          (failure) => null,
          (posts) => allPosts.addAll(posts),
        );
      }

      // Sort by distance
      allPosts.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
      return allPosts;
    } else {
      // Load posts from specific layer
      final result = await ref.read(layerRepositoryProvider).getGeoPosts(
            layerId: layerId,
            latitude: lat,
            longitude: lng,
            radiusKm: radius,
          );

      return result.fold(
        (failure) => throw Exception(failure.message),
        (posts) => posts,
      );
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
