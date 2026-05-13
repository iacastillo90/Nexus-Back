import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/feed_repository.dart';

/// Use case for liking a post
class LikePostUseCase {
  final FeedRepository repository;

  LikePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String postId) async {
    return await repository.likePost(postId);
  }
}
