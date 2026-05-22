import 'package:dio/dio.dart';
import '../models/geo_post_model.dart';

/// Geo post data source for API calls
class GeoPostDataSource {
  final Dio dio;

  GeoPostDataSource(this.dio);

  /// Get geo-posts near location
  Future<List<GeoPostModel>> getGeoPosts({
    required String layerId,
    required double latitude,
    required double longitude,
    required double radiusKm,
  }) async {
    try {
      final response = await dio.get(
        '/layers/$layerId/posts/nearby',
        queryParameters: {
          'lat': latitude,
          'lng': longitude,
          'radius': radiusKm * 1000, // Convert km to meters
        },
      );

      final List<dynamic> data = response.data;
      return data.map((json) => GeoPostModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Create geo-post
  Future<GeoPostModel> createGeoPost({
    required String content,
    required String realityLayer,
    required double latitude,
    required double longitude,
    String? locationName,
    List<String>? mediaUrls,
  }) async {
    try {
      final response = await dio.post(
        '/posts/geo',
        data: {
          'content': content,
          'realityLayer': realityLayer,
          'latitude': latitude,
          'longitude': longitude,
          'locationName': locationName,
          'mediaUrls': mediaUrls,
        },
      );

      return GeoPostModel.fromJson(response.data);
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
        case 404:
          return Exception('Resource not found');
        case 401:
          return Exception('Unauthorized');
        case 500:
          return Exception('Server error: $message');
        default:
          return Exception('Error $statusCode: $message');
      }
    } else {
      return Exception('Network error');
    }
  }
}
