// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      actorId: json['actorId'] as String?,
      actorName: json['actorName'] as String?,
      actorAvatar: json['actorAvatar'] as String?,
      targetId: json['targetId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'title': instance.title,
      'message': instance.message,
      'actorId': instance.actorId,
      'actorName': instance.actorName,
      'actorAvatar': instance.actorAvatar,
      'targetId': instance.targetId,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
    };
