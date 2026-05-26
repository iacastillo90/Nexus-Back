import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_datasource.dart';

/// Implementation of SearchRepository
class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<SearchResultEntity>>> search({
    required String query,
    SearchResultType? type,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final typeString = type != null ? _typeToString(type) : null;

      final models = await dataSource.search(
        query: query,
        type: typeString,
        offset: offset,
        limit: limit,
      );

      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRecentSearches() async {
    try {
      final searches = await dataSource.getRecentSearches();
      return Right(searches);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSearch(String query) async {
    try {
      await dataSource.saveSearch(query);
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearRecentSearches() async {
    try {
      await dataSource.clearRecentSearches();
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchResultEntity>>> getTrendingTags() async {
    try {
      final models = await dataSource.getTrendingTags();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  String _typeToString(SearchResultType type) {
    switch (type) {
      case SearchResultType.user:
        return 'user';
      case SearchResultType.post:
        return 'post';
      case SearchResultType.tag:
        return 'tag';
    }
  }
}
