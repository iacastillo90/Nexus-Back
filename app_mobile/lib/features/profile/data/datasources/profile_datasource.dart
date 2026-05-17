import 'package:dio/dio.dart';
import '../models/profile_model.dart';
import '../models/karma_model.dart';

/// Profile data source
class ProfileDataSource {
  final Dio dio;

  ProfileDataSource(this.dio);

  /// Get user profile by ID
  Future<ProfileModel> getProfile(String userId) async {
    try {
      final response = await dio.get('/users/$userId/profile');
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get current user profile
  Future<ProfileModel> getCurrentProfile() async {
    try {
      final response = await dio.get('/users/me/profile');
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Update profile
  Future<ProfileModel> updateProfile({
    String? bio,
    String? location,
    String? website,
    String? avatarUrl,
    String? coverImageUrl,
  }) async {
    try {
      final response = await dio.put(
        '/users/me/profile',
        data: {
          if (bio != null) 'bio': bio,
          if (location != null) 'location': location,
          if (website != null) 'website': website,
          if (avatarUrl != null) 'avatar': avatarUrl,
          if (coverImageUrl != null) 'coverImage': coverImageUrl,
        },
      );
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Follow user
  Future<void> followUser(String userId) async {
    try {
      await dio.post('/users/$userId/follow');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Unfollow user
  Future<void> unfollowUser(String userId) async {
    try {
      await dio.delete('/users/$userId/follow');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get karma details
  Future<KarmaModel> getKarmaDetails(String userId) async {
    try {
      final response = await dio.get('/users/$userId/karma');
      return KarmaModel.fromJson(response.data);
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
          return Exception('User not found');
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
