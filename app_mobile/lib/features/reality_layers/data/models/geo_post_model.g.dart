// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeoPostModelImpl _$$GeoPostModelImplFromJson(Map<String, dynamic> json) =>
    _$GeoPostModelImpl(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorAvatar: json['authorAvatar'] as String?,
      content: json['content'] as String,
      mediaUrls: (json['mediaUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      realityLayer: json['realityLayer'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      locationName: json['locationName'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$GeoPostModelImplToJson(_$GeoPostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'content': instance.content,
      'mediaUrls': instance.mediaUrls,
      'realityLayer': instance.realityLayer,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'locationName': instance.locationName,
      'createdAt': instance.createdAt.toIso8601String(),
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'isLiked': instance.isLiked,
      'distance': instance.distance,
    };
