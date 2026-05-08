// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_contribution_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DreamContributionModelImpl _$$DreamContributionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DreamContributionModelImpl(
      id: json['id'] as String,
      dreamId: json['dreamId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String?,
      content: json['content'] as String,
      order: (json['order'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$$DreamContributionModelImplToJson(
        _$DreamContributionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dreamId': instance.dreamId,
      'userId': instance.userId,
      'userName': instance.userName,
      'userAvatar': instance.userAvatar,
      'content': instance.content,
      'order': instance.order,
      'createdAt': instance.createdAt.toIso8601String(),
      'likeCount': instance.likeCount,
      'isLiked': instance.isLiked,
    };
