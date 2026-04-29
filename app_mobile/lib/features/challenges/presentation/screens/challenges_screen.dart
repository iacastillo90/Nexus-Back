import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/widgets/widgets.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Nexus Challenges'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.space16),
        children: [
          // Featured Challenge
          _buildFeaturedChallenge(),
          const SizedBox(height: AppDimensions.space24),

          // Active Challenges
          Text(
            'ACTIVE MISSIONS',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: AppDimensions.space16),
          _buildChallengeCard(
            title: 'Neon Nights',
            description: 'Capture the best neon lights in your city.',
            reward: '500 Karma',
            timeLeft: '2 days left',
            progress: 0.7,
            color: AppColors.neonPink,
          ),
          _buildChallengeCard(
            title: 'Digital Zen',
            description: 'Meditate with The Echo for 10 minutes.',
            reward: '200 Karma',
            timeLeft: '5 hours left',
            progress: 0.3,
            color: AppColors.nexusBlue,
          ),
          _buildChallengeCard(
            title: 'Glitch Art',
            description: 'Create a glitch art piece using the editor.',
            reward: '1000 Karma',
            timeLeft: '1 week left',
            progress: 0.0,
            color: AppColors.cyberPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedChallenge() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.nexusBlue, AppColors.cyberPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.emoji_events,
              size: 150,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'WEEKLY SPECIAL',
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'The Architect\'s Choice',
                  style: AppTypography.headlineSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Design a new reality layer concept.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                NexusButton(
                  text: 'Accept Challenge',
                  type: NexusButtonType.ghost,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String description,
    required String reward,
    required String timeLeft,
    required double progress,
    required Color color,
  }) {
    return NexusCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      borderColor: color.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.titleMedium.copyWith(color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  reward,
                  style: AppTypography.labelSmall.copyWith(color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                timeLeft,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTypography.labelSmall.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.deepSpace,
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
