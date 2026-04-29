import 'package:flutter/material.dart';
import 'package:nexus_mobile/app/theme/app_colors.dart';
import 'package:nexus_mobile/app/theme/app_typography.dart';

/// Reusable auth header with shader gradient text
class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title with shader gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.nexusBlue,
              AppColors.cyberPurple,
            ],
          ).createShader(bounds),
          child: Text(
            title,
            style: AppTypography.displaySmall.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
