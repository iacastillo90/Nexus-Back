import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../providers/content_providers.dart';
import '../widgets/media_preview_grid.dart';
import '../widgets/upload_progress_indicator.dart';
import '../widgets/visibility_selector.dart';
import '../widgets/content_dna_badge.dart';

/// Create post screen
class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String _visibility = 'public'; // 'public' or 'private'

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        await ref
            .read(createPostControllerProvider.notifier)
            .uploadMedia(image.path, 'image');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: AppColors.errorFlare,
          ),
        );
      }
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (photo != null) {
        await ref
            .read(createPostControllerProvider.notifier)
            .uploadMedia(photo.path, 'image');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to take photo: $e'),
            backgroundColor: AppColors.errorFlare,
          ),
        );
      }
    }
  }

  Future<void> _createPost() async {
    final content = _contentController.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some content'),
          backgroundColor: AppColors.errorFlare,
        ),
      );
      return;
    }

    final post = await ref
        .read(createPostControllerProvider.notifier)
        .createPost(content: content);

    if (post != null && mounted) {
      // Success - reset and go back
      ref.read(createPostControllerProvider.notifier).reset();
      context.pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post created successfully!'),
          backgroundColor: AppColors.karmaVerified,
        ),
      );
    } else if (mounted) {
      // Error
      final error = ref.read(createPostControllerProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Failed to create post'),
          backgroundColor: AppColors.errorFlare,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createPostControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          if (!state.isCreatingPost && !state.isUploading)
            TextButton(
              onPressed: _createPost,
              child: Text(
                'Post',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.nexusBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content input
            TextField(
              controller: _contentController,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'What\'s on your mind?',
                hintStyle: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textTertiary,
                ),
                border: InputBorder.none,
              ),
              maxLines: null,
              minLines: 5,
              autofocus: true,
            ),

            const SizedBox(height: AppDimensions.space24),

            // Media preview
            if (state.uploadedMedia.isNotEmpty) ...[
              MediaPreviewGrid(
                media: state.uploadedMedia,
                onRemove: (index) {
                  ref
                      .read(createPostControllerProvider.notifier)
                      .removeMedia(index);
                },
              ),
              const SizedBox(height: AppDimensions.space16),
            ],

            // Upload progress
            if (state.isUploading) ...[
              UploadProgressIndicator(
                uploadProgress: state.uploadProgress,
              ),
              const SizedBox(height: AppDimensions.space16),
            ],

            // Creating post indicator
            if (state.isCreatingPost) ...[
              Container(
                padding: const EdgeInsets.all(AppDimensions.space16),
                decoration: BoxDecoration(
                  color: AppColors.glassLight,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  border: Border.all(
                    color: AppColors.carbonFiber,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.nexusBlue,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space12),
                    Text(
                      'Creating post...',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.space16),
            ],

            // Visibility selector
            if (!state.isCreatingPost && !state.isUploading) ...[
              Row(
                children: [
                  Text(
                    'Visibility',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space12),
                  VisibilitySelector(
                    selectedVisibility: _visibility,
                    onChanged: (value) {
                      setState(() {
                        _visibility = value;
                      });
                    },
                  ),
                  const Spacer(),
                  const ContentDnaBadge(
                    isVerified: true,
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space16),
            ],

            // Media buttons
            if (!state.isCreatingPost && !state.isUploading)
              Row(
                children: [
                  Expanded(
                    child: NexusButton(
                      onPressed: _pickImage,
                      type: NexusButtonType.secondary,
                      text: 'Gallery',
                      icon: Icons.photo_library,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space12),
                  Expanded(
                    child: NexusButton(
                      onPressed: _takePhoto,
                      type: NexusButtonType.secondary,
                      text: 'Camera',
                      icon: Icons.camera_alt,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
