import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/geo_post_entity.dart';

part 'geo_post_model.freezed.dart';
part 'geo_post_model.g.dart';

/// Geo post model for JSON serialization
@freezed
class GeoPostModel with _$GeoPostModel {
  const factory GeoPostModel({
    required String id,
    required String authorId,
    required String authorName,
    String? authorAvatar,
    required String content,
    List<String>? mediaUrls,
    required String realityLayer,
    required double latitude,
    required double longitude,
    String? locationName,
    required DateTime createdAt,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(false) bool isLiked,
    double? distance,
  }) = _GeoPostModel;

  const GeoPostModel._();

  /// From JSON
  factory GeoPostModel.fromJson(Map<String, dynamic> json) =>
      _$GeoPostModelFromJson(json);

  /// To Entity
  GeoPostEntity toEntity() {
    return GeoPostEntity(
      id: id,
      authorId: authorId,
      authorName: authorName,
      authorAvatar: authorAvatar,
      content: content,
      mediaUrls: mediaUrls,
      realityLayer: realityLayer,
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
      createdAt: createdAt,
      likeCount: likeCount,
      commentCount: commentCount,
      isLiked: isLiked,
      distance: distance,
    );
  }
}
