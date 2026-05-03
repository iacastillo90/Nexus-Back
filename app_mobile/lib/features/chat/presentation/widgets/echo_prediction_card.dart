import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Echo prediction card - AI response preview
class EchoPredictionCard extends StatefulWidget {
  final String previewText;
  final String mentorName;
  final Color mentorColor;

  const EchoPredictionCard({
    super.key,
    required this.previewText,
    this.mentorName = 'AI',
    this.mentorColor = AppColors.nexusBlue,
  });

  @override
  State<EchoPredictionCard> createState() => _EchoPredictionCardState();
}

class _EchoPredictionCardState extends State<EchoPredictionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            margin: const EdgeInsets.only(
              left: AppDimensions.space16,
              right: AppDimensions.space64,
              bottom: AppDimensions.space12,
            ),
            child: Stack(
              children: [
                // Main card
                Container(
                  padding: const EdgeInsets.all(AppDimensions.space16),
                  decoration: BoxDecoration(
                    color: AppColors.glassLight,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMedium,
                    ),
                    border: Border.all(
                      color: widget.mentorColor.withValues(alpha: 0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.mentorColor.withValues(alpha: 0.2),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 16,
                            color: widget.mentorColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${widget.mentorName} is thinking...',
                            style: AppTypography.labelSmall.copyWith(
                              color: widget.mentorColor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimensions.space12),

                      // Preview text with shimmer
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [
                              _shimmerAnimation.value - 0.3,
                              _shimmerAnimation.value,
                              _shimmerAnimation.value + 0.3,
                            ],
                            colors: [
                              AppColors.textSecondary,
                              widget.mentorColor.withValues(alpha: 0.8),
                              AppColors.textSecondary,
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          widget.previewText,
                          style: AppTypography.bodyMedium.copyWith(
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppDimensions.space12),

                      // Loading indicator
                      Row(
                        children: [
                          SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.mentorColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Generating response...',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textTertiary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Animated border glow
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                      border: Border.all(
                        color: widget.mentorColor.withValues(alpha: 
                          0.3 * _pulseAnimation.value,
                        ),
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
