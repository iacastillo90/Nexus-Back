import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/vibes_entity.dart';

/// Vibes radar chart widget with neon colors
class VibesRadarChart extends StatefulWidget {
  final VibesEntity vibes;

  const VibesRadarChart({
    super.key,
    required this.vibes,
  });

  @override
  State<VibesRadarChart> createState() => _VibesRadarChartState();
}

class _VibesRadarChartState extends State<VibesRadarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emotions = ['joy', 'anger', 'sadness', 'fear', 'surprise'];

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: RadarChart(
            RadarChartData(
              radarShape: RadarShape.polygon,
              tickCount: 5,
              ticksTextStyle: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
                fontSize: 10,
              ),
              radarBorderData: const BorderSide(
                color: AppColors.carbonFiber,
                width: 1,
              ),
              gridBorderData: BorderSide(
                color: AppColors.carbonFiber.withValues(alpha: 0.3),
                width: 1,
              ),
              tickBorderData: const BorderSide(
                color: Colors.transparent,
              ),
              getTitle: (index, angle) {
                final emotion = emotions[index];
                final icon = widget.vibes.getEmotionIcon(emotion);
                final color = widget.vibes.getEmotionColor(emotion);

                return const RadarChartTitle(
                  text: '',
                  positionPercentageOffset: 0.2,
                );
              },
              dataSets: [
                RadarDataSet(
                  fillColor: AppColors.nexusBlue.withValues(alpha: 0.2 * _animation.value),
                  borderColor: AppColors.nexusBlue,
                  borderWidth: 2,
                  entryRadius: 3,
                  dataEntries: emotions.map((emotion) {
                    final value = widget.vibes.getEmotion(emotion) * _animation.value;
                    return RadarEntry(value: value);
                  }).toList(),
                ),
              ],
            ),
            swapAnimationDuration: const Duration(milliseconds: 300),
          ),
        );
      },
    );
  }
}
