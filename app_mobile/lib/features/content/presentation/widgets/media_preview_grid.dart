import 'package:flutter/material.dart';
import '../../../../core/widgets/nexus_network_image.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../domain/entities/media_entity.dart';

/// Media preview grid widget
class MediaPreviewGrid extends StatelessWidget {
  final List<MediaEntity> media;
  final Function(int)? onRemove;

  const MediaPreviewGrid({
    super.key,
    required this.media,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (media.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: media.length,
        itemBuilder: (context, index) {
          final item = media[index];

          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: AppDimensions.space8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              color: AppColors.shadowGrey,
            ),
            child: Stack(
              children: [
                // Media preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                  child: item.isImage
                      ? NexusNetworkImage(
                          imageUrl: item.url,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Icon(
                            item.isVideo
                                ? Icons.videocam
                                : Icons.audiotrack,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                        ),
                ),

                // Remove button
                if (onRemove != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => onRemove!(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.voidBlack.withValues(alpha: 0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
