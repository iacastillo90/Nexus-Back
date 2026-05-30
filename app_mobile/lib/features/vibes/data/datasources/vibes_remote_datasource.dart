import 'package:dio/dio.dart';
import '../models/vibes_dashboard_model.dart';

/// Vibes remote data source
class VibesRemoteDataSource {
  final Dio dio;

  VibesRemoteDataSource(this.dio);

  /// Get user vibes
  Future<VibesDashboardModel> getUserVibes(String userId) async {
    try {
      final response = await dio.get('/vibes/user/$userId');
      return VibesDashboardModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get community pulse
  Future<Map<String, double>> getCommunityPulse() async {
    try {
      final response = await dio.get('/vibes/community-pulse');
      return Map<String, double>.from(response.data['emotions']);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      return Exception(e.response?.data['error'] ?? 'Server error');
    } else {
      return Exception('Network error');
    }
  }
}
