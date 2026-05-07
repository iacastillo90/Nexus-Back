import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Upload progress indicator widget
class UploadProgressIndicator extends StatelessWidget {
  final Map<int, double> uploadProgress;

  const UploadProgressIndicator({
    super.key,
    required this.uploadProgress,
  });

  @override
  Widget build(BuildContext context) {
    if (uploadProgress.isEmpty) return const SizedBox.shrink();

    return Container(
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
          Row(
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
                'Uploading ${uploadProgress.length} ${uploadProgress.length == 1 ? 'file' : 'files'}...',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.space12),
          ...uploadProgress.entries.map((entry) {
            final index = entry.key;
            final progress = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.space8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'File ${index + 1}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.nexusBlue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColors.carbonFiber,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.nexusBlue,
                      ),
                      minHeight: 4,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
