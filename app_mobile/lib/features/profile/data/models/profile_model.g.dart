// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      coverImage: json['coverImage'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      followersCount: (json['followersCount'] as num).toInt(),
      followingCount: (json['followingCount'] as num).toInt(),
      postsCount: (json['postsCount'] as num).toInt(),
      karma: KarmaModel.fromJson(json['karma'] as Map<String, dynamic>),
      badges: (json['badges'] as List<dynamic>?)
          ?.map((e) => BadgeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isFollowing: json['isFollowing'] as bool?,
      isPremium: json['isPremium'] as bool?,
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'avatar': instance.avatar,
      'coverImage': instance.coverImage,
      'bio': instance.bio,
      'location': instance.location,
      'website': instance.website,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'postsCount': instance.postsCount,
      'karma': instance.karma,
      'badges': instance.badges,
      'createdAt': instance.createdAt.toIso8601String(),
      'isFollowing': instance.isFollowing,
      'isPremium': instance.isPremium,
    };
