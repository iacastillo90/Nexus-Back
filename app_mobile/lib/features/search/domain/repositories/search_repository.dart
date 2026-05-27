import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/search_result_entity.dart';

/// Search repository interface
abstract class SearchRepository {
  /// Search for users, posts, and tags
  Future<Either<Failure, List<SearchResultEntity>>> search({
    required String query,
    SearchResultType? type,
    int offset = 0,
    int limit = 20,
  });

  /// Get recent searches
  Future<Either<Failure, List<String>>> getRecentSearches();

  /// Save search query
  Future<Either<Failure, void>> saveSearch(String query);

  /// Clear recent searches
  Future<Either<Failure, void>> clearRecentSearches();

  /// Get trending tags
  Future<Either<Failure, List<SearchResultEntity>>> getTrendingTags();
}
