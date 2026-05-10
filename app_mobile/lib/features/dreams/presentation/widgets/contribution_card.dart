import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../domain/entities/dream_contribution_entity.dart';

/// Contribution card widget for dream timeline
class ContributionCard extends StatelessWidget {
  final DreamContributionEntity contribution;
  final VoidCallback onLike;

  const ContributionCard({
    super.key,
    required this.contribution,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.space16),
      padding: const EdgeInsets.all(AppDimensions.space16),
      decoration: BoxDecoration(
        color: AppColors.glassLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: AppColors.carbonFiber,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with user info
          Row(
            children: [
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.nexusBlue.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.nexusBlue,
                    width: 1,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          contribution.userName,
                          style: AppTypography.titleSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cyberPurple.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            contribution.getOrderLabel(),
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.cyberPurple,
                              fontWeight: FontWeight.w700,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      contribution.timeAgo(),
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),

              // Like button
              GestureDetector(
                onTap: onLike,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: contribution.isLiked
                        ? AppColors.neonPink.withValues(alpha: 0.2)
                        : AppColors.glassLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: contribution.isLiked
                          ? AppColors.neonPink
                          : AppColors.carbonFiber,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        contribution.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: contribution.isLiked
                            ? AppColors.neonPink
                            : AppColors.textTertiary,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${contribution.likeCount}',
                        style: AppTypography.labelSmall.copyWith(
                          color: contribution.isLiked
                              ? AppColors.neonPink
                              : AppColors.textTertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.space12),

          // Content
          Text(
            contribution.content,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
