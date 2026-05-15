import 'package:dartz/dartz.dart';
import 'dart:async';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_datasource.dart';

/// Implementation of NotificationsRepository
class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsDataSource dataSource;
  final StreamController<NotificationEntity> _notificationController =
      StreamController<NotificationEntity>.broadcast();

  NotificationsRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    required String userId,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final models = await dataSource.getNotifications(
        userId: userId,
        offset: offset,
        limit: limit,
      );

      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String notificationId) async {
    try {
      await dataSource.markAsRead(notificationId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead(String userId) async {
    try {
      await dataSource.markAllAsRead(userId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(String notificationId) async {
    try {
      await dataSource.deleteNotification(notificationId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount(String userId) async {
    try {
      final count = await dataSource.getUnreadCount(userId);
      return Right(count);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<NotificationEntity> get onNewNotification =>
      _notificationController.stream;

  /// Emit new notification (called by Socket.IO listener)
  void emitNotification(NotificationEntity notification) {
    _notificationController.add(notification);
  }

  void dispose() {
    _notificationController.close();
  }
}
