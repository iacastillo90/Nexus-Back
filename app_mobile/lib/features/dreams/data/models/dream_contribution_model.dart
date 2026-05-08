import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dream_contribution_entity.dart';

part 'dream_contribution_model.freezed.dart';
part 'dream_contribution_model.g.dart';

/// Dream contribution model for JSON serialization
@freezed
class DreamContributionModel with _$DreamContributionModel {
  const factory DreamContributionModel({
    required String id,
    required String dreamId,
    required String userId,
    required String userName,
    String? userAvatar,
    required String content,
    required int order,
    required DateTime createdAt,
    @Default(0) int likeCount,
    @Default(false) bool isLiked,
  }) = _DreamContributionModel;

  const DreamContributionModel._();

  /// From JSON
  factory DreamContributionModel.fromJson(Map<String, dynamic> json) =>
      _$DreamContributionModelFromJson(json);

  /// To Entity
  DreamContributionEntity toEntity() {
    return DreamContributionEntity(
      id: id,
      dreamId: dreamId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      content: content,
      order: order,
      createdAt: createdAt,
      likeCount: likeCount,
      isLiked: isLiked,
    );
  }
}
