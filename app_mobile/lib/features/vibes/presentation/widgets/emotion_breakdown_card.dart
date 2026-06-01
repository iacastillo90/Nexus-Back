import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../domain/entities/vibes_entity.dart';

/// Emotion breakdown card with pie chart
class EmotionBreakdownCard extends StatefulWidget {
  final VibesEntity vibes;

  const EmotionBreakdownCard({
    super.key,
    required this.vibes,
  });

  @override
  State<EmotionBreakdownCard> createState() => _EmotionBreakdownCardState();
}

class _EmotionBreakdownCardState extends State<EmotionBreakdownCard> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final emotions = widget.vibes.emotions.entries.toList();

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
          // Title
          Text(
            'Emotion Breakdown',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: AppDimensions.space24),

          // Pie chart
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 50,
                sections: emotions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final emotion = entry.value;
                  final isTouched = index == touchedIndex;
                  final radius = isTouched ? 70.0 : 60.0;
                  final fontSize = isTouched ? 16.0 : 12.0;

                  return PieChartSectionData(
                    color: widget.vibes.getEmotionColor(emotion.key),
                    value: emotion.value,
                    title: '${emotion.value.toInt()}%',
                    radius: radius,
                    titleStyle: AppTypography.labelMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: fontSize,
                    ),
                    badgeWidget: isTouched
                        ? Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.darkMatter,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: widget.vibes.getEmotionColor(emotion.key),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              widget.vibes.getEmotionIcon(emotion.key),
                              color: widget.vibes.getEmotionColor(emotion.key),
                              size: 20,
                            ),
                          )
                        : null,
                    badgePositionPercentageOffset: 1.3,
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: AppDimensions.space24),

          // Legend
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: emotions.map((emotion) {
              return _buildLegendItem(
                emotion.key,
                emotion.value,
                widget.vibes.getEmotionColor(emotion.key),
                widget.vibes.getEmotionIcon(emotion.key),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    String emotion,
    double value,
    Color color,
    IconData icon,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        const SizedBox(width: 6),
        Text(
          '${emotion[0].toUpperCase()}${emotion.substring(1)}',
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '${value.toInt()}%',
          style: AppTypography.labelSmall.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
