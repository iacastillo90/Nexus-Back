import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/notification_entity.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

/// Notification model for JSON serialization
@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String userId,
    required String type,
    required String title,
    required String message,
    String? actorId,
    String? actorName,
    String? actorAvatar,
    String? targetId,
    required DateTime createdAt,
    @Default(false) bool isRead,
  }) = _NotificationModel;

  const NotificationModel._();

  /// From JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  /// To Entity
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      userId: userId,
      type: _parseNotificationType(type),
      title: title,
      message: message,
      actorId: actorId,
      actorName: actorName,
      actorAvatar: actorAvatar,
      targetId: targetId,
      createdAt: createdAt,
      isRead: isRead,
    );
  }

  NotificationType _parseNotificationType(String type) {
    switch (type.toLowerCase()) {
      case 'like':
        return NotificationType.like;
      case 'comment':
        return NotificationType.comment;
      case 'follow':
        return NotificationType.follow;
      case 'mention':
        return NotificationType.mention;
      case 'system':
        return NotificationType.system;
      default:
        return NotificationType.system;
    }
  }
}
