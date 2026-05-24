// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$layerDataSourceHash() => r'20719d864532092dae1b59c3b7e5d037f18baa5f';

/// Layer datasource provider
///
/// Copied from [layerDataSource].
@ProviderFor(layerDataSource)
final layerDataSourceProvider = AutoDisposeProvider<LayerDataSource>.internal(
  layerDataSource,
  name: r'layerDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$layerDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LayerDataSourceRef = AutoDisposeProviderRef<LayerDataSource>;
String _$geoPostDataSourceHash() => r'5c3a06ef774ac30e13e1cf71beacb02062701469';

/// Geo post datasource provider
///
/// Copied from [geoPostDataSource].
@ProviderFor(geoPostDataSource)
final geoPostDataSourceProvider =
    AutoDisposeProvider<GeoPostDataSource>.internal(
  geoPostDataSource,
  name: r'geoPostDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$geoPostDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GeoPostDataSourceRef = AutoDisposeProviderRef<GeoPostDataSource>;
String _$locationDataSourceHash() =>
    r'509a1196f10c35bad054ba7f26f8db8fac4820df';

/// Location datasource provider
///
/// Copied from [locationDataSource].
@ProviderFor(locationDataSource)
final locationDataSourceProvider =
    AutoDisposeProvider<LocationDataSource>.internal(
  locationDataSource,
  name: r'locationDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationDataSourceRef = AutoDisposeProviderRef<LocationDataSource>;
String _$layerRepositoryHash() => r'88affbd604f4238d3ea99bd2dd8564de0c98ed9e';

/// Layer repository provider
///
/// Copied from [layerRepository].
@ProviderFor(layerRepository)
final layerRepositoryProvider = AutoDisposeProvider<LayerRepository>.internal(
  layerRepository,
  name: r'layerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$layerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LayerRepositoryRef = AutoDisposeProviderRef<LayerRepository>;
String _$realityLayersHash() => r'4b483844c3e45fd64b69e44cd68311356cebd32d';

/// Reality layers provider
///
/// Copied from [RealityLayers].
@ProviderFor(RealityLayers)
final realityLayersProvider = AutoDisposeNotifierProvider<RealityLayers,
    List<RealityLayerEntity>>.internal(
  RealityLayers.new,
  name: r'realityLayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$realityLayersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RealityLayers = AutoDisposeNotifier<List<RealityLayerEntity>>;
String _$selectedLayerHash() => r'19421588114ba4e760cc132c24e208988f192574';

/// Selected layer provider
///
/// Copied from [SelectedLayer].
@ProviderFor(SelectedLayer)
final selectedLayerProvider =
    AutoDisposeNotifierProvider<SelectedLayer, String?>.internal(
  SelectedLayer.new,
  name: r'selectedLayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedLayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedLayer = AutoDisposeNotifier<String?>;
String _$mapRadiusHash() => r'6ffa694f17d42995933293260713d95fe439f234';

/// Map radius provider (in km)
///
/// Copied from [MapRadius].
@ProviderFor(MapRadius)
final mapRadiusProvider =
    AutoDisposeNotifierProvider<MapRadius, double>.internal(
  MapRadius.new,
  name: r'mapRadiusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mapRadiusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MapRadius = AutoDisposeNotifier<double>;
String _$userLocationHash() => r'dd0d4c73de9d2d572fe8dfba571fedd578956133';

/// User location provider
///
/// Copied from [UserLocation].
@ProviderFor(UserLocation)
final userLocationProvider =
    AutoDisposeAsyncNotifierProvider<UserLocation, Position>.internal(
  UserLocation.new,
  name: r'userLocationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserLocation = AutoDisposeAsyncNotifier<Position>;
String _$geoPostsHash() => r'dc628393b42c94e9ec0b8c8a4fdd372dcc584a42';

/// Geo posts controller
///
/// Copied from [GeoPosts].
@ProviderFor(GeoPosts)
final geoPostsProvider =
    AutoDisposeAsyncNotifierProvider<GeoPosts, List<GeoPostEntity>>.internal(
  GeoPosts.new,
  name: r'geoPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$geoPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GeoPosts = AutoDisposeAsyncNotifier<List<GeoPostEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
