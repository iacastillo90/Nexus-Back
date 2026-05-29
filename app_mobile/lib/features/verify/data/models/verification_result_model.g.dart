// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerificationResultModelImpl _$$VerificationResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationResultModelImpl(
      contentId: json['contentId'] as String,
      contentDNA: json['contentDNA'] as String,
      status: json['status'] as String,
      authenticityScore: (json['authenticityScore'] as num).toDouble(),
      verifiedAt: DateTime.parse(json['verifiedAt'] as String),
      originalAuthor: json['originalAuthor'] as String?,
      originalSource: json['originalSource'] as String?,
      originalDate: json['originalDate'] == null
          ? null
          : DateTime.parse(json['originalDate'] as String),
      modifications: (json['modifications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$VerificationResultModelImplToJson(
        _$VerificationResultModelImpl instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'contentDNA': instance.contentDNA,
      'status': instance.status,
      'authenticityScore': instance.authenticityScore,
      'verifiedAt': instance.verifiedAt.toIso8601String(),
      'originalAuthor': instance.originalAuthor,
      'originalSource': instance.originalSource,
      'originalDate': instance.originalDate?.toIso8601String(),
      'modifications': instance.modifications,
    };
