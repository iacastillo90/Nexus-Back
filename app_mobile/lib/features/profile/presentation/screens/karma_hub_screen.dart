import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../domain/entities/karma_entity.dart';

class KarmaHubScreen extends StatelessWidget {
  final KarmaEntity karma;

  const KarmaHubScreen({
    required this.karma,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Karma Hub'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  Text(
                    karma.totalScore.toString(),
                    style: AppTypography.displayLarge.copyWith(
                      color: _getTierColor(karma.tier),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'KARMA SCORE',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getTierColor(karma.tier).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _getTierColor(karma.tier)),
                    ),
                    child: Text(
                      karma.tier.toUpperCase(),
                      style: AppTypography.labelMedium.copyWith(
                        color: _getTierColor(karma.tier),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Radar Chart
            SizedBox(
              height: 300,
              child: RadarChart(
                RadarChartData(
                  radarTouchData: RadarTouchData(enabled: false),
                  dataSets: [
                    RadarDataSet(
                      fillColor: _getTierColor(karma.tier).withValues(alpha: 0.2),
                      borderColor: _getTierColor(karma.tier),
                      entryRadius: 2,
                      dataEntries: [
                        RadarEntry(value: karma.authenticityScore.toDouble()),
                        RadarEntry(value: karma.communityScore.toDouble()),
                        RadarEntry(value: karma.contributionScore.toDouble()),
                        RadarEntry(value: karma.consistencyScore.toDouble()),
                      ],
                    ),
                  ],
                  radarBackgroundColor: Colors.transparent,
                  borderData: FlBorderData(show: false),
                  radarBorderData: const BorderSide(color: AppColors.glassLight),
                  titlePositionPercentageOffset: 0.2,
                  titleTextStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 10),
                  getTitle: (index, angle) {
                    switch (index) {
                      case 0:
                        return RadarChartTitle(text: 'Authenticity');
                      case 1:
                        return RadarChartTitle(text: 'Community');
                      case 2:
                        return RadarChartTitle(text: 'Contribution');
                      case 3:
                        return RadarChartTitle(text: 'Consistency');
                      default:
                        return const RadarChartTitle(text: '');
                    }
                  },
                  tickCount: 1,
                  ticksTextStyle: const TextStyle(color: Colors.transparent),
                  tickBorderData: const BorderSide(color: Colors.transparent),
                  gridBorderData: const BorderSide(color: AppColors.glassLight, width: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Privileges Section
            Text(
              'PRIVILEGES',
              style: AppTypography.titleMedium.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            _buildPrivilegeItem(
              'Voice Cloning',
              'Create your digital voice twin.',
              karma.privileges.contains('voice_clone'),
            ),
            _buildPrivilegeItem(
              'Reality Layers',
              'Post content in AR locations.',
              karma.privileges.contains('reality_layers'),
            ),
            _buildPrivilegeItem(
              'Priority Support',
              'Direct line to the Council.',
              karma.privileges.contains('priority_support'),
            ),
            _buildPrivilegeItem(
              'Dream Creation',
              'Start new collective dreams.',
              karma.privileges.contains('dream_creation'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivilegeItem(String title, String subtitle, bool isUnlocked) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.deepSpace,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked ? AppColors.nexusBlue.withValues(alpha: 0.5) : AppColors.glassLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isUnlocked ? AppColors.nexusBlue.withValues(alpha: 0.2) : Colors.black,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isUnlocked ? Icons.lock_open : Icons.lock,
              color: isUnlocked ? AppColors.nexusBlue : AppColors.textTertiary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyLarge.copyWith(
                    color: isUnlocked ? Colors.white : AppColors.textSecondary,
                    decoration: isUnlocked ? null : TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTierColor(String tier) {
    switch (tier.toLowerCase()) {
      case 'legendary':
        return Colors.amber;
      case 'verified':
        return Colors.greenAccent;
      case 'established':
        return Colors.blueAccent;
      case 'newcomer':
        return Colors.purpleAccent;
      case 'suspicious':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }
}
