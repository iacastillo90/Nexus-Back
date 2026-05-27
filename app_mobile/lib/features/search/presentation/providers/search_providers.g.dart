// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'7cd30c9640ca952d1bcf1772c709fc45dc47c8b3';

/// Shared preferences provider
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeFutureProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef = AutoDisposeFutureProviderRef<SharedPreferences>;
String _$searchDataSourceHash() => r'49641c1dc2f641569ce17fca2e27d54fe6b25de1';

/// Search datasource provider
///
/// Copied from [searchDataSource].
@ProviderFor(searchDataSource)
final searchDataSourceProvider =
    AutoDisposeFutureProvider<SearchDataSource>.internal(
  searchDataSource,
  name: r'searchDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchDataSourceRef = AutoDisposeFutureProviderRef<SearchDataSource>;
String _$searchRepositoryHash() => r'4f68f8f9b0f88a44820df302f324845b5551893f';

/// Search repository provider
///
/// Copied from [searchRepository].
@ProviderFor(searchRepository)
final searchRepositoryProvider =
    AutoDisposeFutureProvider<SearchRepository>.internal(
  searchRepository,
  name: r'searchRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchRepositoryRef = AutoDisposeFutureProviderRef<SearchRepository>;
String _$searchQueryHash() => r'185286cbd043ae154c5e2f9f60456d8249203d25';

/// Search query provider
///
/// Copied from [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider =
    AutoDisposeNotifierProvider<SearchQuery, String>.internal(
  SearchQuery.new,
  name: r'searchQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQuery = AutoDisposeNotifier<String>;
String _$searchFilterHash() => r'1329824c41524ea45cd5d5132a71448f9370c5b3';

/// Search filter type provider
///
/// Copied from [SearchFilter].
@ProviderFor(SearchFilter)
final searchFilterProvider =
    AutoDisposeNotifierProvider<SearchFilter, SearchResultType?>.internal(
  SearchFilter.new,
  name: r'searchFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchFilter = AutoDisposeNotifier<SearchResultType?>;
String _$searchResultsHash() => r'530e880b934db830de25a8600b71814796c8bfa8';

/// Search results provider
///
/// Copied from [SearchResults].
@ProviderFor(SearchResults)
final searchResultsProvider = AutoDisposeAsyncNotifierProvider<SearchResults,
    List<SearchResultEntity>>.internal(
  SearchResults.new,
  name: r'searchResultsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchResultsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchResults = AutoDisposeAsyncNotifier<List<SearchResultEntity>>;
String _$recentSearchesHash() => r'cc7f656c181985c35d8cb34644bf852433311bf3';

/// Recent searches provider
///
/// Copied from [RecentSearches].
@ProviderFor(RecentSearches)
final recentSearchesProvider =
    AutoDisposeAsyncNotifierProvider<RecentSearches, List<String>>.internal(
  RecentSearches.new,
  name: r'recentSearchesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentSearchesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecentSearches = AutoDisposeAsyncNotifier<List<String>>;
String _$trendingTagsHash() => r'9a3d30b9fe8e48134410da1a8ba4f500fb5057ed';

/// Trending tags provider
///
/// Copied from [TrendingTags].
@ProviderFor(TrendingTags)
final trendingTagsProvider = AutoDisposeAsyncNotifierProvider<TrendingTags,
    List<SearchResultEntity>>.internal(
  TrendingTags.new,
  name: r'trendingTagsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$trendingTagsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TrendingTags = AutoDisposeAsyncNotifier<List<SearchResultEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
