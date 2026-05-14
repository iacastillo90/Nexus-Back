import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../domain/entities/comment_entity.dart';
import 'karma_ring_avatar.dart';

/// Comment card widget
class CommentCard extends StatelessWidget {
  final CommentEntity comment;
  final VoidCallback? onLike;
  final VoidCallback? onDelete;

  const CommentCard({
    super.key,
    required this.comment,
    this.onLike,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.space16,
        vertical: AppDimensions.space8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          KarmaRingAvatar(
            imageUrl: comment.userAvatar,
            initials: comment.username.substring(0, 2).toUpperCase(),
            size: 36,
            karmaScore: 0.6, // TODO: Get from user karma
          ),

          const SizedBox(width: AppDimensions.space12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username and time
                Row(
                  children: [
                    Text(
                      comment.username,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Text(
                      comment.timeAgo,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.space4),

                // Comment text
                Text(
                  comment.content,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: AppDimensions.space8),

                // Actions
                Row(
                  children: [
                    // Like button
                    InkWell(
                      onTap: onLike,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusSmall),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.space4,
                          vertical: AppDimensions.space4,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              comment.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 16,
                              color: comment.isLiked
                                  ? AppColors.holoRose
                                  : AppColors.textTertiary,
                            ),
                            if (comment.likesCount > 0) ...[
                              const SizedBox(width: AppDimensions.space4),
                              Text(
                                comment.likesCount.toString(),
                                style: AppTypography.labelSmall.copyWith(
                                  color: comment.isLiked
                                      ? AppColors.holoRose
                                      : AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    if (onDelete != null) ...[
                      const SizedBox(width: AppDimensions.space16),
                      InkWell(
                        onTap: onDelete,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusSmall),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.space4,
                            vertical: AppDimensions.space4,
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            size: 16,
                            color: AppColors.errorFlare,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
