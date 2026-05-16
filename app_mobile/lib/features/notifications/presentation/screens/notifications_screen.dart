import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/notifications_providers.dart';
import '../widgets/notification_card.dart';
import '../../domain/entities/notification_entity.dart';

/// Notifications screen with list and mark as read
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationsState = ref.watch(userNotificationsProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.nexusBlue,
              AppColors.cyberPurple,
            ],
          ).createShader(bounds),
          child: Text(
            'Notifications',
            style: AppTypography.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              ref.read(userNotificationsProvider.notifier).markAllAsRead();
              ref.read(unreadNotificationsCountProvider.notifier).refresh();
            },
            tooltip: 'Mark all as read',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.nexusBlue,
          labelColor: AppColors.nexusBlue,
          unselectedLabelColor: AppColors.textTertiary,
          labelStyle: AppTypography.labelMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          tabs: [
            Tab(text: 'All (${unreadCount.value ?? 0})'),
            const Tab(text: 'Likes'),
            const Tab(text: 'Comments'),
            const Tab(text: 'Follows'),
            const Tab(text: 'Mentions'),
            const Tab(text: 'System'),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userNotificationsProvider.notifier).refresh();
          await ref.read(unreadNotificationsCountProvider.notifier).refresh();
        },
        color: AppColors.nexusBlue,
        backgroundColor: AppColors.darkMatter,
        child: notificationsState.when(
          data: (notifications) {
            if (notifications.isEmpty) {
              return _buildEmptyState();
            }

            return TabBarView(
              controller: _tabController,
              children: [
                _buildNotificationsList(notifications),
                _buildNotificationsList(_filterByType(
                  notifications,
                  NotificationType.like,
                )),
                _buildNotificationsList(_filterByType(
                  notifications,
                  NotificationType.comment,
                )),
                _buildNotificationsList(_filterByType(
                  notifications,
                  NotificationType.follow,
                )),
                _buildNotificationsList(_filterByType(
                  notifications,
                  NotificationType.mention,
                )),
                _buildNotificationsList(_filterByType(
                  notifications,
                  NotificationType.system,
                )),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.nexusBlue),
            ),
          ),
          error: (error, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.errorFlare,
                ),
                const SizedBox(height: AppDimensions.space16),
                Text(
                  'Error loading notifications',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimensions.space8),
                Text(
                  error.toString(),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsList(List<NotificationEntity> notifications) {
    if (notifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.space16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];

        return NotificationCard(
          notification: notification,
          onTap: () {
            if (!notification.isRead) {
              ref
                  .read(userNotificationsProvider.notifier)
                  .markAsRead(notification.id);
              ref.read(unreadNotificationsCountProvider.notifier).refresh();
            }

            // Navigate to target (post, profile, etc.)
            _handleNotificationTap(notification);
          },
          onDismiss: () {
            ref
                .read(userNotificationsProvider.notifier)
                .deleteNotification(notification.id);
            ref.read(unreadNotificationsCountProvider.notifier).refresh();
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_none,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppDimensions.space16),
          Text(
            'No notifications',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            'You\'re all caught up!',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  List<NotificationEntity> _filterByType(
    List<NotificationEntity> notifications,
    NotificationType type,
  ) {
    return notifications.where((n) => n.type == type).toList();
  }

  void _handleNotificationTap(NotificationEntity notification) {
    // Navigate based on notification type and targetId
    switch (notification.type) {
      case NotificationType.like:
      case NotificationType.comment:
      case NotificationType.mention:
        if (notification.targetId != null) {
          // Navigate to post detail
          // context.push('/post/${notification.targetId}');
        }
        break;
      case NotificationType.follow:
        if (notification.actorId != null) {
          // Navigate to user profile
          // context.push('/profile/${notification.actorId}');
        }
        break;
      case NotificationType.system:
        // Handle system notification
        break;
    }
  }
}
