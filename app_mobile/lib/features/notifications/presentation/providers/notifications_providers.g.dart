// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationsDataSourceHash() =>
    r'411dabcb9d2e706fcb6b2aebbcf3e3f40c4dbeb4';

/// Notifications datasource provider
///
/// Copied from [notificationsDataSource].
@ProviderFor(notificationsDataSource)
final notificationsDataSourceProvider =
    AutoDisposeProvider<NotificationsDataSource>.internal(
  notificationsDataSource,
  name: r'notificationsDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationsDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationsDataSourceRef
    = AutoDisposeProviderRef<NotificationsDataSource>;
String _$notificationsRepositoryHash() =>
    r'1bc3f966030832f4eb2e8e29e06f2933c187b037';

/// Notifications repository provider
///
/// Copied from [notificationsRepository].
@ProviderFor(notificationsRepository)
final notificationsRepositoryProvider =
    AutoDisposeProvider<NotificationsRepository>.internal(
  notificationsRepository,
  name: r'notificationsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationsRepositoryRef
    = AutoDisposeProviderRef<NotificationsRepository>;
String _$userNotificationsHash() => r'657ecc416bdcfa67fab8880160682bdffe1a67f9';

/// User notifications provider
///
/// Copied from [UserNotifications].
@ProviderFor(UserNotifications)
final userNotificationsProvider = AutoDisposeAsyncNotifierProvider<
    UserNotifications, List<NotificationEntity>>.internal(
  UserNotifications.new,
  name: r'userNotificationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userNotificationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserNotifications
    = AutoDisposeAsyncNotifier<List<NotificationEntity>>;
String _$unreadNotificationsCountHash() =>
    r'2966b113cbf3fc19253bc2821987bd13c155060d';

/// Unread notifications count provider
///
/// Copied from [UnreadNotificationsCount].
@ProviderFor(UnreadNotificationsCount)
final unreadNotificationsCountProvider =
    AutoDisposeAsyncNotifierProvider<UnreadNotificationsCount, int>.internal(
  UnreadNotificationsCount.new,
  name: r'unreadNotificationsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadNotificationsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UnreadNotificationsCount = AutoDisposeAsyncNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
