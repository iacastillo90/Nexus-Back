import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

class PrismInsightsScreen extends StatelessWidget {
  const PrismInsightsScreen({super.key});

  // Mock Data for now
  final List<Map<String, dynamic>> insights = const [
    {
      'type': 'personality',
      'title': 'The Architect',
      'content': 'Your pattern of creating structured content suggests a high level of organizational thinking. You tend to build systems rather than just participating in them.',
      'confidence': 0.92,
      'date': '2h ago',
      'icon': Icons.architecture,
      'color': Colors.amber,
    },
    {
      'type': 'emotion',
      'title': 'Emotional Resonance',
      'content': 'Recent interactions show a spike in empathy. Your comments on "Project Gaia" were particularly resonant with the community sentiment.',
      'confidence': 0.88,
      'date': '5h ago',
      'icon': Icons.favorite,
      'color': Colors.pinkAccent,
    },
    {
      'type': 'social',
      'title': 'Network Node',
      'content': 'You are becoming a central node for "Tech Ethics" discussions. 15% of your followers are now second-degree connections from this cluster.',
      'confidence': 0.85,
      'date': '1d ago',
      'icon': Icons.hub,
      'color': Colors.cyanAccent,
    },
    {
      'type': 'creative',
      'title': 'Divergent Thinker',
      'content': 'Your content DNA shows high variance in topic clusters, indicating a divergent thinking style typical of innovators.',
      'confidence': 0.78,
      'date': '2d ago',
      'icon': Icons.lightbulb,
      'color': Colors.purpleAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('The Prism'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: insights.length,
        itemBuilder: (context, index) {
          final insight = insights[index];
          return _buildInsightCard(context, insight)
              .animate()
              .fadeIn(duration: 600.ms, delay: (100 * index).ms)
              .slideY(begin: 0.1, end: 0);
        },
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context, Map<String, dynamic> insight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.deepSpace,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (insight['color'] as Color).withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: (insight['color'] as Color).withValues(alpha: 0.1),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (insight['color'] as Color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    insight['icon'] as IconData,
                    color: insight['color'] as Color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight['title'] as String,
                        style: AppTypography.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        (insight['type'] as String).toUpperCase(),
                        style: AppTypography.labelSmall.copyWith(
                          color: (insight['color'] as Color),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  insight['date'] as String,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              insight['content'] as String,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Confidence: ${((insight['confidence'] as double) * 100).toInt()}%',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    value: insight['confidence'] as double,
                    backgroundColor: AppColors.glassLight,
                    valueColor: AlwaysStoppedAnimation<Color>(insight['color'] as Color),
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
