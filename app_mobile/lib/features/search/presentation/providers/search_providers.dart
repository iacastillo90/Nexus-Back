import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nexus_mobile/core/network/dio_provider.dart';
import '../../data/datasources/search_datasource.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/search_repository.dart';
import '../../domain/entities/search_result_entity.dart';

part 'search_providers.g.dart';

/// Shared preferences provider
@riverpod
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async {
  return await SharedPreferences.getInstance();
}

/// Search datasource provider
@riverpod
Future<SearchDataSource> searchDataSource(SearchDataSourceRef ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return SearchDataSource(ref.watch(networkDioProvider), prefs);
}

/// Search repository provider
@riverpod
Future<SearchRepository> searchRepository(SearchRepositoryRef ref) async {
  final dataSource = await ref.watch(searchDataSourceProvider.future);
  return SearchRepositoryImpl(dataSource: dataSource);
}

/// Search query provider
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() {
    return '';
  }

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

/// Search filter type provider
@riverpod
class SearchFilter extends _$SearchFilter {
  @override
  SearchResultType? build() {
    return null; // null = all types
  }

  void setFilter(SearchResultType? type) {
    state = type;
  }
}

/// Search results provider
@riverpod
class SearchResults extends _$SearchResults {
  @override
  Future<List<SearchResultEntity>> build() async {
    final query = ref.watch(searchQueryProvider);
    final filter = ref.watch(searchFilterProvider);

    if (query.isEmpty) {
      return [];
    }

    return _performSearch(query, filter);
  }

  Future<List<SearchResultEntity>> _performSearch(
    String query,
    SearchResultType? type,
  ) async {
    final repository = await ref.read(searchRepositoryProvider.future);
    final result = await repository.search(
      query: query,
      type: type,
      offset: 0,
      limit: 50,
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (results) => results,
    );
  }

  Future<void> saveSearch(String query) async {
    final repository = await ref.read(searchRepositoryProvider.future);
    await repository.saveSearch(query);
    ref.read(recentSearchesProvider.notifier).refresh();
  }
}

/// Recent searches provider
@riverpod
class RecentSearches extends _$RecentSearches {
  @override
  Future<List<String>> build() async {
    final repository = await ref.read(searchRepositoryProvider.future);
    final result = await repository.getRecentSearches();

    return result.fold(
      (failure) => [],
      (searches) => searches,
    );
  }

  Future<void> clear() async {
    final repository = await ref.read(searchRepositoryProvider.future);
    await repository.clearRecentSearches();
    ref.invalidateSelf();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// Trending tags provider
@riverpod
class TrendingTags extends _$TrendingTags {
  @override
  Future<List<SearchResultEntity>> build() async {
    final repository = await ref.read(searchRepositoryProvider.future);
    final result = await repository.getTrendingTags();

    return result.fold(
      (failure) => [],
      (tags) => tags,
    );
  }
}
