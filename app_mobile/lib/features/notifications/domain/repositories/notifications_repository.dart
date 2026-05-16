import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/notification_entity.dart';

/// Notifications repository interface
abstract class NotificationsRepository {
  /// Get user notifications
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    required String userId,
    int offset = 0,
    int limit = 20,
  });

  /// Mark notification as read
  Future<Either<Failure, void>> markAsRead(String notificationId);

  /// Mark all notifications as read
  Future<Either<Failure, void>> markAllAsRead(String userId);

  /// Delete notification
  Future<Either<Failure, void>> deleteNotification(String notificationId);

  /// Get unread count
  Future<Either<Failure, int>> getUnreadCount(String userId);

  /// Stream of new notifications (real-time)
  Stream<NotificationEntity> get onNewNotification;
}
