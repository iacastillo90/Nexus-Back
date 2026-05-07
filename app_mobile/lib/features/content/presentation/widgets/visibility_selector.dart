import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Visibility selector widget (PUBLIC/PRIVATE chips)
class VisibilitySelector extends StatelessWidget {
  final String selectedVisibility; // 'public' or 'private'
  final Function(String) onChanged;

  const VisibilitySelector({
    super.key,
    required this.selectedVisibility,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.space4),
      decoration: BoxDecoration(
        color: AppColors.glassLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: AppColors.carbonFiber,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _VisibilityChip(
            label: 'PUBLIC',
            icon: Icons.public,
            isSelected: selectedVisibility == 'public',
            onTap: () => onChanged('public'),
            color: AppColors.nexusBlue,
          ),
          const SizedBox(width: AppDimensions.space4),
          _VisibilityChip(
            label: 'PRIVATE',
            icon: Icons.lock,
            isSelected: selectedVisibility == 'private',
            onTap: () => onChanged('private'),
            color: AppColors.cyberPurple,
          ),
        ],
      ),
    );
  }
}

class _VisibilityChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _VisibilityChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space12,
          vertical: AppDimensions.space8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          border: Border.all(
            color: isSelected ? color : AppColors.carbonFiber,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? color : AppColors.textSecondary,
            ),
            const SizedBox(width: AppDimensions.space4),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected ? color : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
