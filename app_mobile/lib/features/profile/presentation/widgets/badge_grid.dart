import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../domain/entities/badge_entity.dart';

/// Badge grid widget
class BadgeGrid extends StatelessWidget {
  final List<BadgeEntity> badges;

  const BadgeGrid({
    super.key,
    required this.badges,
  });

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.space32),
          child: Column(
            children: [
              const Icon(
                Icons.emoji_events_outlined,
                size: 48,
                color: AppColors.textTertiary,
              ),
              const SizedBox(height: AppDimensions.space16),
              Text(
                'No badges yet',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: AppDimensions.space8),
              Text(
                'Earn badges by contributing to the community',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: AppDimensions.space8,
        mainAxisSpacing: AppDimensions.space8,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        final badge = badges[index];

        return GestureDetector(
          onTap: () {
            _showBadgeDetails(context, badge);
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.glassLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              border: Border.all(
                color: badge.isRare == true
                    ? AppColors.karmaVerified
                    : AppColors.carbonFiber,
                width: badge.isRare == true ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_events,
                  size: 32,
                  color: badge.isRare == true
                      ? AppColors.karmaVerified
                      : AppColors.nexusBlue,
                ),
                const SizedBox(height: 4),
                Text(
                  badge.name,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBadgeDetails(BuildContext context, BadgeEntity badge) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkMatter,
        title: Text(
          badge.name,
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.emoji_events,
              size: 64,
              color: badge.isRare == true
                  ? AppColors.karmaVerified
                  : AppColors.nexusBlue,
            ),
            const SizedBox(height: AppDimensions.space16),
            Text(
              badge.description,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.space12),
            Text(
              'Earned: ${badge.earnedAt.toString().split(' ')[0]}',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            if (badge.level != null) ...[
              const SizedBox(height: 4),
              Text(
                'Level ${badge.level}',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.nexusBlue,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.nexusBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
