import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/karma_entity.dart';

part 'karma_model.freezed.dart';
part 'karma_model.g.dart';

/// Karma model for JSON serialization
@freezed
class KarmaModel with _$KarmaModel {
  const factory KarmaModel({
    required int totalScore,
    required int authenticityScore,
    required int contributionScore,
    required int communityScore,
    required int consistencyScore,
    required String tier,
    required double tierProgress,
    @Default([]) List<String> privileges,
    int? rank,
    int? weeklyChange,
  }) = _KarmaModel;

  const KarmaModel._();

  /// From JSON
  factory KarmaModel.fromJson(Map<String, dynamic> json) =>
      _$KarmaModelFromJson(json);

  /// To Entity
  KarmaEntity toEntity() {
    return KarmaEntity(
      totalScore: totalScore,
      authenticityScore: authenticityScore,
      contributionScore: contributionScore,
      communityScore: communityScore,
      consistencyScore: consistencyScore,
      tier: tier,
      tierProgress: tierProgress,
      privileges: privileges,
      rank: rank,
      weeklyChange: weeklyChange,
    );
  }
}
