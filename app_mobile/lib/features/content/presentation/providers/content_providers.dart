import 'package:nexus_mobile/core/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/media_upload_datasource.dart';
import '../../data/datasources/post_creation_datasource.dart';
import '../../data/repositories/content_repository_impl.dart';
import '../../domain/repositories/content_repository.dart';
import '../../domain/entities/media_entity.dart';
import '../../domain/entities/create_post_request.dart';
import '../../../feed/domain/entities/post_entity.dart';

part 'content_providers.g.dart';

/// Media upload datasource provider
@riverpod
MediaUploadDataSource mediaUploadDataSource(MediaUploadDataSourceRef ref) {
  return MediaUploadDataSource(ref.watch(networkDioProvider));
}

/// Post creation datasource provider
@riverpod
PostCreationDataSource postCreationDataSource(PostCreationDataSourceRef ref) {
  return PostCreationDataSource(ref.watch(networkDioProvider));
}

/// Content repository provider
@riverpod
ContentRepository contentRepository(ContentRepositoryRef ref) {
  return ContentRepositoryImpl(
    mediaUploadDataSource: ref.watch(mediaUploadDataSourceProvider),
    postCreationDataSource: ref.watch(postCreationDataSourceProvider),
  );
}

/// Create post state
class CreatePostState {
  final List<MediaEntity> uploadedMedia;
  final Map<int, double> uploadProgress; // index -> progress (0.0 to 1.0)
  final bool isCreatingPost;
  final String? error;

  CreatePostState({
    this.uploadedMedia = const [],
    this.uploadProgress = const {},
    this.isCreatingPost = false,
    this.error,
  });

  CreatePostState copyWith({
    List<MediaEntity>? uploadedMedia,
    Map<int, double>? uploadProgress,
    bool? isCreatingPost,
    String? error,
  }) {
    return CreatePostState(
      uploadedMedia: uploadedMedia ?? this.uploadedMedia,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      isCreatingPost: isCreatingPost ?? this.isCreatingPost,
      error: error,
    );
  }

  bool get isUploading => uploadProgress.isNotEmpty;
}

/// Create post controller provider
@riverpod
class CreatePostController extends _$CreatePostController {
  @override
  CreatePostState build() {
    return CreatePostState();
  }

  /// Upload media file
  Future<void> uploadMedia(String filePath, String type) async {
    final index = state.uploadedMedia.length;

    // Add progress tracker
    final newProgress = Map<int, double>.from(state.uploadProgress);
    newProgress[index] = 0.0;
    state = state.copyWith(uploadProgress: newProgress);

    final result = await ref.read(contentRepositoryProvider).uploadMedia(
          filePath: filePath,
          type: type,
          onProgress: (progress) {
            final updatedProgress = Map<int, double>.from(state.uploadProgress);
            updatedProgress[index] = progress;
            state = state.copyWith(uploadProgress: updatedProgress);
          },
        );

    result.fold(
      (failure) {
        // Remove progress tracker on error
        final updatedProgress = Map<int, double>.from(state.uploadProgress);
        updatedProgress.remove(index);
        state = state.copyWith(
          uploadProgress: updatedProgress,
          error: failure.message,
        );
      },
      (media) {
        // Remove progress tracker and add media
        final updatedProgress = Map<int, double>.from(state.uploadProgress);
        updatedProgress.remove(index);
        state = state.copyWith(
          uploadedMedia: [...state.uploadedMedia, media],
          uploadProgress: updatedProgress,
        );
      },
    );
  }

  /// Remove uploaded media
  void removeMedia(int index) {
    final updatedMedia = [...state.uploadedMedia];
    updatedMedia.removeAt(index);
    state = state.copyWith(uploadedMedia: updatedMedia);
  }

  /// Create post
  Future<PostEntity?> createPost({
    required String content,
    String? realityLayer,
    double? latitude,
    double? longitude,
    String? locationName,
  }) async {
    state = state.copyWith(isCreatingPost: true, error: null);

    final request = CreatePostRequest(
      content: content,
      mediaUrls: state.uploadedMedia.map((m) => m.url).toList(),
      mediaType: state.uploadedMedia.isNotEmpty
          ? state.uploadedMedia.first.type
          : null,
      realityLayer: realityLayer,
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
    );

    final result = await ref.read(contentRepositoryProvider).createPost(request);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isCreatingPost: false,
          error: failure.message,
        );
        return null;
      },
      (post) {
        state = state.copyWith(isCreatingPost: false);
        return post;
      },
    );
  }

  /// Reset state
  void reset() {
    state = CreatePostState();
  }
}
