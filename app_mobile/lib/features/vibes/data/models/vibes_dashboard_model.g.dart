// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vibes_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VibesDashboardModelImpl _$$VibesDashboardModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VibesDashboardModelImpl(
      userId: json['userId'] as String,
      vibeScore: (json['vibeScore'] as num).toDouble(),
      emotions: (json['emotions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$VibesDashboardModelImplToJson(
        _$VibesDashboardModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'vibeScore': instance.vibeScore,
      'emotions': instance.emotions,
      'timestamp': instance.timestamp.toIso8601String(),
    };
