// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karma_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KarmaModelImpl _$$KarmaModelImplFromJson(Map<String, dynamic> json) =>
    _$KarmaModelImpl(
      totalScore: (json['totalScore'] as num).toInt(),
      authenticityScore: (json['authenticityScore'] as num).toInt(),
      contributionScore: (json['contributionScore'] as num).toInt(),
      communityScore: (json['communityScore'] as num).toInt(),
      consistencyScore: (json['consistencyScore'] as num).toInt(),
      tier: json['tier'] as String,
      tierProgress: (json['tierProgress'] as num).toDouble(),
      privileges: (json['privileges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rank: (json['rank'] as num?)?.toInt(),
      weeklyChange: (json['weeklyChange'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$KarmaModelImplToJson(_$KarmaModelImpl instance) =>
    <String, dynamic>{
      'totalScore': instance.totalScore,
      'authenticityScore': instance.authenticityScore,
      'contributionScore': instance.contributionScore,
      'communityScore': instance.communityScore,
      'consistencyScore': instance.consistencyScore,
      'tier': instance.tier,
      'tierProgress': instance.tierProgress,
      'privileges': instance.privileges,
      'rank': instance.rank,
      'weeklyChange': instance.weeklyChange,
    };
