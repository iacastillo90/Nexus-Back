import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/badge_entity.dart';

part 'badge_model.freezed.dart';
part 'badge_model.g.dart';

/// Badge model for JSON serialization
@freezed
class BadgeModel with _$BadgeModel {
  const factory BadgeModel({
    required String id,
    required String name,
    required String description,
    required String iconUrl,
    required String category,
    required DateTime earnedAt,
    int? level,
    bool? isRare,
  }) = _BadgeModel;

  const BadgeModel._();

  /// From JSON
  factory BadgeModel.fromJson(Map<String, dynamic> json) =>
      _$BadgeModelFromJson(json);

  /// To Entity
  BadgeEntity toEntity() {
    return BadgeEntity(
      id: id,
      name: name,
      description: description,
      iconUrl: iconUrl,
      category: category,
      earnedAt: earnedAt,
      level: level,
      isRare: isRare,
    );
  }
}
