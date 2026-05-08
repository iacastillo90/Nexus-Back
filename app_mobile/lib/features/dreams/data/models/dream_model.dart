import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dream_entity.dart';

part 'dream_model.freezed.dart';
part 'dream_model.g.dart';

/// Dream model for JSON serialization
@freezed
class DreamModel with _$DreamModel {
  const factory DreamModel({
    required String id,
    required String title,
    required String description,
    required String creatorId,
    required String creatorName,
    String? creatorAvatar,
    required int maxContributions,
    required int currentContributions,
    required String status,
    required DateTime createdAt,
    DateTime? completedAt,
    @Default([]) List<String> tags,
    @Default(0) int viewCount,
    @Default(0) int likeCount,
  }) = _DreamModel;

  const DreamModel._();

  /// From JSON
  factory DreamModel.fromJson(Map<String, dynamic> json) =>
      _$DreamModelFromJson(json);

  /// To Entity
  DreamEntity toEntity() {
    return DreamEntity(
      id: id,
      title: title,
      description: description,
      creatorId: creatorId,
      creatorName: creatorName,
      creatorAvatar: creatorAvatar,
      maxContributions: maxContributions,
      currentContributions: currentContributions,
      status: _parseStatus(status),
      createdAt: createdAt,
      completedAt: completedAt,
      tags: tags,
      viewCount: viewCount,
      likeCount: likeCount,
    );
  }

  DreamStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return DreamStatus.active;
      case 'completed':
        return DreamStatus.completed;
      case 'archived':
        return DreamStatus.archived;
      default:
        return DreamStatus.active;
    }
  }
}
