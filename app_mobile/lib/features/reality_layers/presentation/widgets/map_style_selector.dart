import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Map style selector widget
class MapStyleSelector extends StatelessWidget {
  final String selectedStyle;
  final Function(String) onStyleChanged;

  const MapStyleSelector({
    super.key,
    required this.selectedStyle,
    required this.onStyleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final styles = {
      'dark': {'name': 'Dark', 'icon': Icons.dark_mode},
      'cyber': {'name': 'Cyber', 'icon': Icons.electric_bolt},
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.space8,
        vertical: AppDimensions.space8,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkMatter.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: AppColors.carbonFiber,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: styles.entries.map((entry) {
          final styleId = entry.key;
          final styleName = entry.value['name'] as String;
          final styleIcon = entry.value['icon'] as IconData;
          final isSelected = selectedStyle == styleId;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onStyleChanged(styleId),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: styleId == 'cyber'
                              ? [
                                  AppColors.cyberPurple,
                                  AppColors.neonPink,
                                ]
                              : [
                                  AppColors.nexusBlue,
                                  const Color(0xFF0099CC),
                                ],
                        )
                      : null,
                  color: isSelected ? null : AppColors.glassLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? (styleId == 'cyber'
                            ? AppColors.cyberPurple
                            : AppColors.nexusBlue)
                        : AppColors.carbonFiber,
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: (styleId == 'cyber'
                                    ? AppColors.cyberPurple
                                    : AppColors.nexusBlue)
                                .withValues(alpha: 0.3),
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
                      styleIcon,
                      size: 16,
                      color: isSelected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      styleName,
                      style: AppTypography.labelMedium.copyWith(
                        color: isSelected
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
