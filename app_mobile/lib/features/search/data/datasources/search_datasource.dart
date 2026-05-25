import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/search_result_model.dart';

/// Search data source
class SearchDataSource {
  final Dio dio;
  final SharedPreferences prefs;
  static const String _recentSearchesKey = 'recent_searches';

  SearchDataSource(this.dio, this.prefs);

  /// Search for results
  Future<List<SearchResultModel>> search({
    required String query,
    String? type,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        '/search',
        queryParameters: {
          'q': query,
          if (type != null) 'type': type,
          'offset': offset,
          'limit': limit,
        },
      );

      final List<dynamic> data = response.data;
      return data.map((json) => SearchResultModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get recent searches
  Future<List<String>> getRecentSearches() async {
    return prefs.getStringList(_recentSearchesKey) ?? [];
  }

  /// Save search query
  Future<void> saveSearch(String query) async {
    final recent = await getRecentSearches();

    // Remove if already exists
    recent.remove(query);

    // Add to beginning
    recent.insert(0, query);

    // Keep only last 10
    if (recent.length > 10) {
      recent.removeRange(10, recent.length);
    }

    await prefs.setStringList(_recentSearchesKey, recent);
  }

  /// Clear recent searches
  Future<void> clearRecentSearches() async {
    await prefs.remove(_recentSearchesKey);
  }

  /// Get trending tags
  Future<List<SearchResultModel>> getTrendingTags() async {
    try {
      final response = await dio.get('/search/trending-tags');
      final List<dynamic> data = response.data;
      return data.map((json) => SearchResultModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle Dio errors
  Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data?['message'] ?? 'Unknown error';
      return Exception('Error $statusCode: $message');
    } else {
      return Exception('Connection error');
    }
  }
}
