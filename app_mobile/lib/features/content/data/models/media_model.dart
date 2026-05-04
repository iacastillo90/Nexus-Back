import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/media_entity.dart';

part 'media_model.freezed.dart';
part 'media_model.g.dart';

/// Media model for JSON serialization
@freezed
class MediaModel with _$MediaModel {
  const factory MediaModel({
    required String url,
    required String type,
    String? thumbnailUrl,
    int? width,
    int? height,
    int? duration,
    int? size,
  }) = _MediaModel;

  const MediaModel._();

  /// From JSON
  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  /// To Entity
  MediaEntity toEntity() {
    return MediaEntity(
      url: url,
      type: type,
      thumbnailUrl: thumbnailUrl,
      width: width,
      height: height,
      duration: duration,
      size: size,
    );
  }

  /// From Entity
  factory MediaModel.fromEntity(MediaEntity entity) {
    return MediaModel(
      url: entity.url,
      type: entity.type,
      thumbnailUrl: entity.thumbnailUrl,
      width: entity.width,
      height: entity.height,
      duration: entity.duration,
      size: entity.size,
    );
  }
}
