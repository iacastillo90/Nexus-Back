import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../feed/domain/entities/post_entity.dart';
import '../entities/media_entity.dart';
import '../entities/create_post_request.dart';

/// Content repository interface
abstract class ContentRepository {
  /// Upload media file
  Future<Either<Failure, MediaEntity>> uploadMedia({
    required String filePath,
    required String type,
    Function(double)? onProgress,
  });

  /// Create post
  Future<Either<Failure, PostEntity>> createPost(CreatePostRequest request);

  /// Delete media
  Future<Either<Failure, Unit>> deleteMedia(String url);
}
