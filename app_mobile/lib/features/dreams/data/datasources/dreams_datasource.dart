import 'package:dio/dio.dart';
import '../models/dream_model.dart';
import '../models/dream_contribution_model.dart';

/// Dreams data source
class DreamsDataSource {
  final Dio dio;

  DreamsDataSource(this.dio);

  /// Get dreams
  Future<List<DreamModel>> getDreams({
    String? status,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        '/dreams',
        queryParameters: {
          if (status != null) 'status': status,
          'offset': offset,
          'limit': limit,
        },
      );

      final List<dynamic> data = response.data;
      return data.map((json) => DreamModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get dream by ID
  Future<DreamModel> getDream(String dreamId) async {
    try {
      final response = await dio.get('/dreams/$dreamId');
      return DreamModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get dream contributions
  Future<List<DreamContributionModel>> getDreamContributions(
    String dreamId,
  ) async {
    try {
      final response = await dio.get('/dreams/$dreamId/contributions');
      final List<dynamic> data = response.data;
      return data
          .map((json) => DreamContributionModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Create dream
  Future<DreamModel> createDream({
    required String title,
    required String description,
    required int maxContributions,
    List<String>? tags,
  }) async {
    try {
      final response = await dio.post(
        '/dreams',
        data: {
          'title': title,
          'description': description,
          'maxContributions': maxContributions,
          'tags': tags ?? [],
        },
      );

      return DreamModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Add contribution
  Future<DreamContributionModel> addContribution({
    required String dreamId,
    required String content,
  }) async {
    try {
      final response = await dio.post(
        '/dreams/$dreamId/contributions',
        data: {'content': content},
      );

      return DreamContributionModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Like dream
  Future<void> likeDream(String dreamId) async {
    try {
      await dio.post('/dreams/$dreamId/like');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Like contribution
  Future<void> likeContribution(String contributionId) async {
    try {
      await dio.post('/dreams/contributions/$contributionId/like');
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
