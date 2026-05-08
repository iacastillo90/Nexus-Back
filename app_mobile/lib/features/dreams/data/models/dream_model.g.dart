// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DreamModelImpl _$$DreamModelImplFromJson(Map<String, dynamic> json) =>
    _$DreamModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      creatorId: json['creatorId'] as String,
      creatorName: json['creatorName'] as String,
      creatorAvatar: json['creatorAvatar'] as String?,
      maxContributions: (json['maxContributions'] as num).toInt(),
      currentContributions: (json['currentContributions'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DreamModelImplToJson(_$DreamModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'creatorId': instance.creatorId,
      'creatorName': instance.creatorName,
      'creatorAvatar': instance.creatorAvatar,
      'maxContributions': instance.maxContributions,
      'currentContributions': instance.currentContributions,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'tags': instance.tags,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
    };
