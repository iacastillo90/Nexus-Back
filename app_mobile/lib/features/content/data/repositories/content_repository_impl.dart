import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../feed/domain/entities/post_entity.dart';
import '../../domain/entities/media_entity.dart';
import '../../domain/entities/create_post_request.dart';
import '../../domain/repositories/content_repository.dart';
import '../datasources/media_upload_datasource.dart';
import '../datasources/post_creation_datasource.dart';

/// Implementation of ContentRepository
class ContentRepositoryImpl implements ContentRepository {
  final MediaUploadDataSource mediaUploadDataSource;
  final PostCreationDataSource postCreationDataSource;

  ContentRepositoryImpl({
    required this.mediaUploadDataSource,
    required this.postCreationDataSource,
  });

  @override
  Future<Either<Failure, MediaEntity>> uploadMedia({
    required String filePath,
    required String type,
    Function(double)? onProgress,
  }) async {
    try {
      final media = await mediaUploadDataSource.uploadMedia(
        filePath: filePath,
        type: type,
        onProgress: onProgress,
      );
      return Right(media);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> createPost(
      CreatePostRequest request) async {
    try {
      final post = await postCreationDataSource.createPost(
        content: request.content,
        mediaUrls: request.mediaUrls,
        mediaType: request.mediaType,
        realityLayer: request.realityLayer,
        latitude: request.latitude,
        longitude: request.longitude,
        locationName: request.locationName,
        metadata: request.metadata,
      );
      return Right(post.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMedia(String url) async {
    try {
      // Extract public_id from Cloudinary URL
      // Format: https://res.cloudinary.com/{cloud_name}/{resource_type}/upload/{public_id}.{format}
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      if (pathSegments.length >= 4) {
        final publicIdWithFormat = pathSegments.sublist(3).join('/');
        final publicId = publicIdWithFormat.split('.').first;
        await mediaUploadDataSource.deleteMedia(publicId);
      }
      return const Right(unit);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
