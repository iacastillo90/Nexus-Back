import 'package:nexus_mobile/core/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/api/dio_client.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/notifications_datasource.dart';
import '../../data/repositories/notifications_repository_impl.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../../domain/entities/notification_entity.dart';

part 'notifications_providers.g.dart';

/// Notifications datasource provider
@riverpod
NotificationsDataSource notificationsDataSource(
    NotificationsDataSourceRef ref) {
  return NotificationsDataSource(ref.watch(networkDioProvider));
}

/// Notifications repository provider
@riverpod
NotificationsRepository notificationsRepository(
    NotificationsRepositoryRef ref) {
  return NotificationsRepositoryImpl(
    dataSource: ref.watch(notificationsDataSourceProvider),
  );
}

/// User notifications provider
@riverpod
class UserNotifications extends _$UserNotifications {
  @override
  Future<List<NotificationEntity>> build() async {
    final authState = ref.watch(authControllerProvider);
    final userId = authState.when(
      data: (user) => user?.id ?? 'demo_user',
      loading: () => 'demo_user',
      error: (_, __) => 'demo_user',
    );

    return _loadNotifications(userId);
  }

  Future<List<NotificationEntity>> _loadNotifications(String userId) async {
    final result = await ref.read(notificationsRepositoryProvider).getNotifications(
          userId: userId,
          offset: 0,
          limit: 50,
        );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (notifications) => notifications,
    );
  }

  Future<void> markAsRead(String notificationId) async {
    await ref.read(notificationsRepositoryProvider).markAsRead(notificationId);

    // Update local state
    state.whenData((notifications) {
      final updated = notifications.map((n) {
        if (n.id == notificationId) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();

      state = AsyncData(updated);
    });
  }

  Future<void> markAllAsRead() async {
    final authState = ref.watch(authControllerProvider);
    final userId = authState.when(
      data: (user) => user?.id ?? 'demo_user',
      loading: () => 'demo_user',
      error: (_, __) => 'demo_user',
    );

    await ref.read(notificationsRepositoryProvider).markAllAsRead(userId);

    // Update local state
    state.whenData((notifications) {
      final updated = notifications.map((n) => n.copyWith(isRead: true)).toList();
      state = AsyncData(updated);
    });
  }

  Future<void> deleteNotification(String notificationId) async {
    await ref
        .read(notificationsRepositoryProvider)
        .deleteNotification(notificationId);

    // Update local state
    state.whenData((notifications) {
      final updated =
          notifications.where((n) => n.id != notificationId).toList();
      state = AsyncData(updated);
    });
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// Unread notifications count provider
@riverpod
class UnreadNotificationsCount extends _$UnreadNotificationsCount {
  @override
  Future<int> build() async {
    final authState = ref.watch(authControllerProvider);
    final userId = authState.when(
      data: (user) => user?.id ?? 'demo_user',
      loading: () => 'demo_user',
      error: (_, __) => 'demo_user',
    );

    final result =
        await ref.read(notificationsRepositoryProvider).getUnreadCount(userId);

    return result.fold(
      (failure) => 0,
      (count) => count,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
