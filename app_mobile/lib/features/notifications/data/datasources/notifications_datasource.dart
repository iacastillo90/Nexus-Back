import 'package:dio/dio.dart';
import '../models/notification_model.dart';

/// Notifications remote data source
class NotificationsDataSource {
  final Dio dio;

  NotificationsDataSource(this.dio);

  /// Get notifications
  Future<List<NotificationModel>> getNotifications({
    required String userId,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        '/notifications',
        queryParameters: {
          'userId': userId,
          'offset': offset,
          'limit': limit,
        },
      );

      final List<dynamic> data = response.data;
      return data.map((json) => NotificationModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Mark as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await dio.put('/notifications/$notificationId/read');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Mark all as read
  Future<void> markAllAsRead(String userId) async {
    try {
      await dio.put('/notifications/read-all', data: {'userId': userId});
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await dio.delete('/notifications/$notificationId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get unread count
  Future<int> getUnreadCount(String userId) async {
    try {
      final response = await dio.get('/notifications/unread-count',
          queryParameters: {'userId': userId});
      return response.data['count'] as int;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle Dio errors
  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      return Exception(e.response?.data['error'] ?? 'Server error');
    } else {
      return Exception('Network error');
    }
  }
}
