import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/feed_repository.dart';

/// Use case for getting feed posts
class GetFeedUseCase {
  final FeedRepository repository;

  GetFeedUseCase(this.repository);

  Future<Either<Failure, List<PostEntity>>> call({
    required int offset,
    required int limit,
  }) async {
    return await repository.getFeed(
      offset: offset,
      limit: limit,
    );
  }
}
