import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Karma tier card widget
class KarmaTierCard extends StatelessWidget {
  final String tier;
  final double progress; // 0.0 to 1.0
  final int currentScore;
  final int nextTierScore;

  const KarmaTierCard({
    super.key,
    required this.tier,
    required this.progress,
    required this.currentScore,
    required this.nextTierScore,
  });

  Color _getTierColor() {
    switch (tier.toLowerCase()) {
      case 'legendary':
        return const Color(0xFFFFD700); // Gold
      case 'verified':
        return AppColors.karmaVerified;
      case 'established':
        return AppColors.nexusBlue;
      case 'newcomer':
        return AppColors.cyberPurple;
      default:
        return AppColors.karmaSuspicious;
    }
  }

  String _getTierDescription() {
    switch (tier.toLowerCase()) {
      case 'legendary':
        return 'Elite member with exceptional contributions';
      case 'verified':
        return 'Trusted member with consistent quality';
      case 'established':
        return 'Active member building reputation';
      case 'newcomer':
        return 'New member exploring the community';
      default:
        return 'Build your reputation';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tierColor = _getTierColor();

    return Container(
      padding: const EdgeInsets.all(AppDimensions.space16),
      decoration: BoxDecoration(
        color: AppColors.glassLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: tierColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: tierColor.withValues(alpha: 0.2),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.verified,
                color: tierColor,
                size: 32,
              ),
              const SizedBox(width: AppDimensions.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tier[0].toUpperCase() + tier.substring(1),
                      style: AppTypography.titleLarge.copyWith(
                        color: tierColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _getTierDescription(),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.space16),

          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$currentScore points',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '$nextTierScore points',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.carbonFiber,
                  valueColor: AlwaysStoppedAnimation<Color>(tierColor),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${(progress * 100).toInt()}% to next tier',
                style: AppTypography.labelSmall.copyWith(
                  color: tierColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
