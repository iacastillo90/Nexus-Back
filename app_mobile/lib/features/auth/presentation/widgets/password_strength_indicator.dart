import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Password strength indicator widget
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  PasswordStrength _calculateStrength() {
    if (password.isEmpty) return PasswordStrength.none;
    if (password.length < 6) return PasswordStrength.weak;

    int score = 0;
    if (password.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    if (score <= 2) return PasswordStrength.weak;
    if (score <= 3) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }

  @override
  Widget build(BuildContext context) {
    final strength = _calculateStrength();

    if (strength == PasswordStrength.none) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppDimensions.space8),
        Row(
          children: [
            Expanded(
              child: _buildStrengthBar(0, strength),
            ),
            const SizedBox(width: AppDimensions.space4),
            Expanded(
              child: _buildStrengthBar(1, strength),
            ),
            const SizedBox(width: AppDimensions.space4),
            Expanded(
              child: _buildStrengthBar(2, strength),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.space8),
        Text(
          strength.label,
          style: AppTypography.bodySmall.copyWith(
            color: strength.color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStrengthBar(int index, PasswordStrength strength) {
    final isActive = index < strength.index;

    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: isActive ? strength.color : AppColors.carbonFiber,
        borderRadius: BorderRadius.circular(2),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: strength.color.withValues(alpha: 0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }
}

enum PasswordStrength {
  none(0, 'No password', AppColors.textTertiary),
  weak(1, 'Weak password', AppColors.errorFlare),
  medium(2, 'Medium password', AppColors.warningPulse),
  strong(3, 'Strong password', AppColors.successGlow);

  @override
  final String label;
  final Color color;

  const PasswordStrength(int index, this.label, this.color);
}
