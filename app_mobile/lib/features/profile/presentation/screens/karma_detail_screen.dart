import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/profile_providers.dart';
import '../widgets/karma_tier_card.dart';

/// Karma detail screen
class KarmaDetailScreen extends ConsumerWidget {
  final String? userId; // null for current user

  const KarmaDetailScreen({
    super.key,
    this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCurrentUser = userId == null;

    final profileState = isCurrentUser
        ? ref.watch(currentProfileProvider)
        : ref.watch(userProfileProvider(userId!));

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Karma Details'),
      ),
      body: profileState.when(
        data: (profile) {
          final karma = profile.karma;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Karma tier card
                KarmaTierCard(
                  tier: karma.tier,
                  progress: karma.tierProgress,
                  currentScore: karma.totalScore,
                  nextTierScore: _getNextTierScore(karma.tier),
                ),

                const SizedBox(height: AppDimensions.space24),

                // Breakdown
                Text(
                  'Karma Breakdown',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.space16),

                _KarmaBreakdownItem(
                  label: 'Authenticity',
                  score: karma.authenticityScore,
                  color: AppColors.nexusBlue,
                  icon: Icons.verified_user,
                ),
                const SizedBox(height: AppDimensions.space12),
                _KarmaBreakdownItem(
                  label: 'Contribution',
                  score: karma.contributionScore,
                  color: AppColors.cyberPurple,
                  icon: Icons.add_circle,
                ),
                const SizedBox(height: AppDimensions.space12),
                _KarmaBreakdownItem(
                  label: 'Community',
                  score: karma.communityScore,
                  color: AppColors.karmaVerified,
                  icon: Icons.people,
                ),
                const SizedBox(height: AppDimensions.space12),
                _KarmaBreakdownItem(
                  label: 'Consistency',
                  score: karma.consistencyScore,
                  color: AppColors.neonPink,
                  icon: Icons.timeline,
                ),

                const SizedBox(height: AppDimensions.space24),

                // Weekly change
                if (karma.weeklyChange != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.space16),
                    decoration: BoxDecoration(
                      color: AppColors.glassLight,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                      border: Border.all(
                        color: AppColors.carbonFiber,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          karma.weeklyChange! >= 0
                              ? Icons.trending_up
                              : Icons.trending_down,
                          color: karma.weeklyChange! >= 0
                              ? AppColors.karmaVerified
                              : AppColors.errorFlare,
                          size: 32,
                        ),
                        const SizedBox(width: AppDimensions.space12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This Week',
                                style: AppTypography.labelMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                '${karma.weeklyChange! >= 0 ? '+' : ''}${karma.weeklyChange} points',
                                style: AppTypography.titleMedium.copyWith(
                                  color: karma.weeklyChange! >= 0
                                      ? AppColors.karmaVerified
                                      : AppColors.errorFlare,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space24),
                ],

                // History placeholder
                Text(
                  'Karma History',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.space16),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.space32),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.show_chart,
                          size: 64,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(height: AppDimensions.space16),
                        Text(
                          'Karma history chart coming soon',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.nexusBlue),
          ),
        ),
        error: (error, stack) => Center(
          child: Text(
            'Error loading karma details',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.errorFlare,
            ),
          ),
        ),
      ),
    );
  }

  int _getNextTierScore(String tier) {
    switch (tier.toLowerCase()) {
      case 'newcomer':
        return 300;
      case 'established':
        return 500;
      case 'verified':
        return 800;
      case 'legendary':
        return 1000;
      default:
        return 1000;
    }
  }
}

class _KarmaBreakdownItem extends StatelessWidget {
  final String label;
  final int score;
  final Color color;
  final IconData icon;

  const _KarmaBreakdownItem({
    required this.label,
    required this.score,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / 250).clamp(0.0, 1.0);

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
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              const SizedBox(width: AppDimensions.space8),
              Text(
                label,
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '$score',
                style: AppTypography.titleMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.space8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppColors.carbonFiber,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
