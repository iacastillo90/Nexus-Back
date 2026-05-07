import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Content DNA badge widget (verified checkmark)
class ContentDnaBadge extends StatelessWidget {
  final bool isVerified;
  final String? dnaHash;

  const ContentDnaBadge({
    super.key,
    this.isVerified = false,
    this.dnaHash,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVerified) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.space8,
        vertical: AppDimensions.space4,
      ),
      decoration: BoxDecoration(
        color: AppColors.karmaVerified.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        border: Border.all(
          color: AppColors.karmaVerified,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.karmaVerified.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified,
            size: 16,
            color: AppColors.karmaVerified,
          ),
          const SizedBox(width: AppDimensions.space4),
          Text(
            'Verified',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.karmaVerified,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (dnaHash != null) ...[
            const SizedBox(width: AppDimensions.space4),
            Icon(
              Icons.fingerprint,
              size: 14,
              color: AppColors.karmaVerified.withValues(alpha: 0.7),
            ),
          ],
        ],
      ),
    );
  }
}
