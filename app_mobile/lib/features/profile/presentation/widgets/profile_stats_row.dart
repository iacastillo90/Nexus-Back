import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Profile stats row widget
class ProfileStatsRow extends StatelessWidget {
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final VoidCallback? onFollowersTap;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onPostsTap;

  const ProfileStatsRow({
    super.key,
    required this.followersCount,
    required this.followingCount,
    required this.postsCount,
    this.onFollowersTap,
    this.onFollowingTap,
    this.onPostsTap,
  });

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _StatItem(
          label: 'Posts',
          value: _formatCount(postsCount),
          onTap: onPostsTap,
        ),
        Container(
          width: 1,
          height: 40,
          color: AppColors.carbonFiber,
        ),
        _StatItem(
          label: 'Followers',
          value: _formatCount(followersCount),
          onTap: onFollowersTap,
        ),
        Container(
          width: 1,
          height: 40,
          color: AppColors.carbonFiber,
        ),
        _StatItem(
          label: 'Following',
          value: _formatCount(followingCount),
          onTap: onFollowingTap,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _StatItem({
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.space12,
          horizontal: AppDimensions.space16,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
