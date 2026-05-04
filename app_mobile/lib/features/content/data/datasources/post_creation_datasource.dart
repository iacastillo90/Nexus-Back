import 'package:dio/dio.dart';
import '../../../feed/data/models/post_model.dart';

/// Post creation data source
class PostCreationDataSource {
  final Dio dio;

  PostCreationDataSource(this.dio);

  /// Create post
  Future<PostModel> createPost({
    required String content,
    List<String>? mediaUrls,
    String? mediaType,
    String? realityLayer,
    double? latitude,
    double? longitude,
    String? locationName,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await dio.post(
        '/posts',
        data: {
          'content': content,
          if (mediaUrls != null && mediaUrls.isNotEmpty) 'mediaUrls': mediaUrls,
          if (mediaType != null) 'mediaType': mediaType,
          if (realityLayer != null) 'realityLayer': realityLayer,
          if (latitude != null) 'latitude': latitude,
          if (longitude != null) 'longitude': longitude,
          if (locationName != null) 'locationName': locationName,
          if (metadata != null) 'metadata': metadata,
        },
      );

      return PostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle Dio errors
  Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 400:
          return Exception('Invalid post data: $message');
        case 401:
          return Exception('Unauthorized: Please login');
        case 413:
          return Exception('Post content too large');
        case 500:
          return Exception('Server error: $message');
        default:
          return Exception('Error $statusCode: $message');
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout');
    } else if (error.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('Failed to create post');
    }
  }
}
