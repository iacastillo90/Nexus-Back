import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/vibes_providers.dart';
import '../widgets/vibes_radar_chart.dart';
import '../widgets/community_pulse_widget.dart';
import '../widgets/emotion_breakdown_card.dart';

/// Vibes dashboard screen with radar chart and community pulse
class VibesDashboardScreen extends ConsumerWidget {
  const VibesDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final userId = authState.when(
      data: (user) => user?.id ?? 'demo_user',
      loading: () => 'demo_user',
      error: (_, __) => 'demo_user',
    );

    final vibesState = ref.watch(userVibesProvider(userId));
    final communityPulseState = ref.watch(communityPulseProvider);

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.nexusBlue,
              AppColors.cyberPurple,
            ],
          ).createShader(bounds),
          child: Text(
            'Vibes Dashboard',
            style: AppTypography.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(userVibesProvider(userId).notifier).refresh();
              ref.read(communityPulseProvider.notifier).refresh();
            },
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.psychology),
            onPressed: () => context.push('/vibes/prism'),
            tooltip: 'Deep Dive (Prism)',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userVibesProvider(userId).notifier).refresh();
          await ref.read(communityPulseProvider.notifier).refresh();
        },
        color: AppColors.nexusBlue,
        backgroundColor: AppColors.darkMatter,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppDimensions.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vibe Score Card
              vibesState.when(
                data: (vibes) => _buildVibeScoreCard(vibes),
                loading: () => _buildLoadingCard(),
                error: (error, _) => _buildErrorCard(error.toString()),
              ),

              const SizedBox(height: AppDimensions.space16),

              // Radar Chart
              vibesState.when(
                data: (vibes) => Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emotion Analysis',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.space8),
                      Text(
                        'Your emotional spectrum over recent activity',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: VibesRadarChart(vibes: vibes),
                      ),
                      // Emotion labels
                      _buildEmotionLabels(vibes),
                    ],
                  ),
                ),
                loading: () => _buildLoadingCard(),
                error: (error, _) => _buildErrorCard(error.toString()),
              ),

              const SizedBox(height: AppDimensions.space16),

              // Dominant Emotion
              vibesState.when(
                data: (vibes) => _buildDominantEmotionCard(vibes),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

              const SizedBox(height: AppDimensions.space16),

              // Community Pulse
              communityPulseState.when(
                data: (pulse) => CommunityPulseWidget(emotions: pulse),
                loading: () => _buildLoadingCard(),
                error: (error, _) => _buildErrorCard(error.toString()),
              ),

              const SizedBox(height: AppDimensions.space16),

              // Emotion Breakdown
              vibesState.when(
                data: (vibes) => EmotionBreakdownCard(vibes: vibes),
                loading: () => _buildLoadingCard(),
                error: (error, _) => _buildErrorCard(error.toString()),
              ),

              const SizedBox(height: AppDimensions.space24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVibeScoreCard(vibes) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.space24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: vibes.getVibeScoreGradient(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: vibes.getVibeScoreGradient()[0].withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Vibe Score',
            style: AppTypography.titleMedium.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppDimensions.space16),
          Text(
            '${vibes.vibeScore.toInt()}',
            style: AppTypography.displayLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 64,
            ),
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            vibes.getVibeScoreInterpretation(),
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDominantEmotionCard(vibes) {
    final dominantEmotion = vibes.getDominantEmotion();
    final color = vibes.getEmotionColor(dominantEmotion);
    final icon = vibes.getEmotionIcon(dominantEmotion);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.space16),
      decoration: BoxDecoration(
        color: AppColors.glassLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          const SizedBox(width: AppDimensions.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dominant Emotion',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${dominantEmotion[0].toUpperCase()}${dominantEmotion.substring(1)}',
                  style: AppTypography.titleMedium.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${vibes.getEmotion(dominantEmotion).toInt()}% intensity',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionLabels(vibes) {
    final emotions = ['joy', 'anger', 'sadness', 'fear', 'surprise'];

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: emotions.map((emotion) {
        final color = vibes.getEmotionColor(emotion);
        final icon = vibes.getEmotionIcon(emotion);

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
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
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.glassLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.nexusBlue),
        ),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.space16),
      decoration: BoxDecoration(
        color: AppColors.glassLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: AppColors.errorFlare,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.errorFlare,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Error loading data',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
