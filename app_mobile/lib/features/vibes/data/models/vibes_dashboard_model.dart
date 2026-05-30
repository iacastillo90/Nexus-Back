import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/vibes_entity.dart';

part 'vibes_dashboard_model.freezed.dart';
part 'vibes_dashboard_model.g.dart';

/// Vibes dashboard model for JSON serialization
@freezed
class VibesDashboardModel with _$VibesDashboardModel {
  const factory VibesDashboardModel({
    required String userId,
    required double vibeScore,
    required Map<String, double> emotions,
    required DateTime timestamp,
  }) = _VibesDashboardModel;

  const VibesDashboardModel._();

  /// From JSON
  factory VibesDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$VibesDashboardModelFromJson(json);

  /// To Entity
  VibesEntity toEntity() {
    return VibesEntity(
      userId: userId,
      vibeScore: vibeScore,
      emotions: emotions,
      timestamp: timestamp,
    );
  }
}
