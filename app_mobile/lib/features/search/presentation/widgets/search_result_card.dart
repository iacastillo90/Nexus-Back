import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/search_result_entity.dart';

/// Search result card widget
class SearchResultCard extends StatelessWidget {
  final SearchResultEntity result;
  final VoidCallback onTap;

  const SearchResultCard({
    super.key,
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = result.getColor();
    final icon = result.getIcon();

    return NexusCard(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: AppDimensions.space8),
      padding: const EdgeInsets.all(AppDimensions.space16),
      borderColor: color.withValues(alpha: 0.3),
      child: Row(
          children: [
            // Icon/Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: result.type == SearchResultType.tag
                    ? BoxShape.rectangle
                    : BoxShape.circle,
                borderRadius: result.type == SearchResultType.tag
                    ? BorderRadius.circular(12)
                    : null,
                border: Border.all(
                  color: color.withValues(alpha: 0.5),
                  width: 2,
                ),
                    ),
            ),

            const SizedBox(width: AppDimensions.space12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    result.title,
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Subtitle
                  Text(
                    result.subtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Metadata badge
            if (_getMetadataText() != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  _getMetadataText()!,
                  style: AppTypography.labelSmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),

            const SizedBox(width: 8),

            // Arrow
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textTertiary,
            ),
          ],
        ),
    );
  }

  String? _getMetadataText() {
    switch (result.type) {
      case SearchResultType.user:
        final count = result.followerCount;
        if (count != null) {
          return '${_formatCount(count)} followers';
        }
        break;
      case SearchResultType.post:
        final count = result.likeCount;
        if (count != null) {
          return '${_formatCount(count)} likes';
        }
        break;
      case SearchResultType.tag:
        final count = result.postCount;
        if (count != null) {
          return '${_formatCount(count)} posts';
        }
        break;
    }
    return null;
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}
