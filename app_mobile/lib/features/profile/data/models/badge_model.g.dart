// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BadgeModelImpl _$$BadgeModelImplFromJson(Map<String, dynamic> json) =>
    _$BadgeModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      category: json['category'] as String,
      earnedAt: DateTime.parse(json['earnedAt'] as String),
      level: (json['level'] as num?)?.toInt(),
      isRare: json['isRare'] as bool?,
    );

Map<String, dynamic> _$$BadgeModelImplToJson(_$BadgeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'category': instance.category,
      'earnedAt': instance.earnedAt.toIso8601String(),
      'level': instance.level,
      'isRare': instance.isRare,
    };
