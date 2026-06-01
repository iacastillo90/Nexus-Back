import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Community pulse widget with animated circle
class CommunityPulseWidget extends StatefulWidget {
  final Map<String, double> emotions;

  const CommunityPulseWidget({
    super.key,
    required this.emotions,
  });

  @override
  State<CommunityPulseWidget> createState() => _CommunityPulseWidgetState();
}

class _CommunityPulseWidgetState extends State<CommunityPulseWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _getAverageEmotion() {
    if (widget.emotions.isEmpty) return 50.0;
    final sum = widget.emotions.values.reduce((a, b) => a + b);
    return sum / widget.emotions.length;
  }

  Color _getPulseColor() {
    final avg = _getAverageEmotion();
    if (avg >= 70) {
      return AppColors.karmaVerified; // Green
    } else if (avg >= 50) {
      return AppColors.nexusBlue; // Blue
    } else if (avg >= 30) {
      return AppColors.cyberPurple; // Purple
    } else {
      return AppColors.holoRose; // Pink
    }
  }

  @override
  Widget build(BuildContext context) {
    final pulseColor = _getPulseColor();
    final avgEmotion = _getAverageEmotion();

    return Container(
      padding: const EdgeInsets.all(AppDimensions.space24),
      decoration: BoxDecoration(
        color: AppColors.glassLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: pulseColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Title
          Text(
            'Community Pulse',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: AppDimensions.space24),

          // Animated pulse circle
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow
                  Container(
                    width: 160 * _pulseAnimation.value,
                    height: 160 * _pulseAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: pulseColor.withValues(alpha: 
                        0.1 / _pulseAnimation.value,
                      ),
                    ),
                  ),

                  // Main circle
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          pulseColor.withValues(alpha: 0.6),
                          pulseColor.withValues(alpha: 0.2),
                        ],
                      ),
                      border: Border.all(
                        color: pulseColor,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: pulseColor.withValues(alpha: 0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${avgEmotion.toInt()}%',
                            style: AppTypography.headlineMedium.copyWith(
                              color: pulseColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Energy',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: AppDimensions.space24),

          // Description
          Text(
            _getPulseDescription(avgEmotion),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getPulseDescription(double avg) {
    if (avg >= 70) {
      return 'The community is thriving with positive energy! 🌟';
    } else if (avg >= 50) {
      return 'Balanced vibes across the network ⚖️';
    } else if (avg >= 30) {
      return 'Community energy is moderate 🌙';
    } else {
      return 'The network needs support 💙';
    }
  }
}
