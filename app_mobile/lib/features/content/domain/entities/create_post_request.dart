import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_request.freezed.dart';

/// Request entity for creating a post
@freezed
class CreatePostRequest with _$CreatePostRequest {
  const factory CreatePostRequest({
    required String content,
    List<String>? mediaUrls,
    String? mediaType,
    String? realityLayer, // 'physical', 'digital', 'hybrid'
    double? latitude,
    double? longitude,
    String? locationName,
    Map<String, dynamic>? metadata,
  }) = _CreatePostRequest;

  const CreatePostRequest._();

  /// Check if post has media
  bool get hasMedia => mediaUrls != null && mediaUrls!.isNotEmpty;

  /// Check if post has location
  bool get hasLocation => latitude != null && longitude != null;
}
