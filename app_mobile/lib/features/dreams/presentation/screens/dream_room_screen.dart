import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/dreams_providers.dart';
import '../widgets/contribution_card.dart';

/// Dream room screen with narrative and contributions
class DreamRoomScreen extends ConsumerStatefulWidget {
  final String dreamId;

  const DreamRoomScreen({
    super.key,
    required this.dreamId,
  });

  @override
  ConsumerState<DreamRoomScreen> createState() => _DreamRoomScreenState();
}

class _DreamRoomScreenState extends ConsumerState<DreamRoomScreen> {
  final TextEditingController _contributionController = TextEditingController();

  @override
  void dispose() {
    _contributionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dreamState = ref.watch(dreamDetailProvider(widget.dreamId));
    final contributionsState =
        ref.watch(dreamContributionsProvider(widget.dreamId));

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: dreamState.when(
          data: (dream) => Text(
            dream.title,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Dream'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ref.read(dreamDetailProvider(widget.dreamId).notifier).likeDream();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Dream info
          dreamState.when(
            data: (dream) => Container(
              padding: const EdgeInsets.all(AppDimensions.space16),
              color: AppColors.glassLight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dream.description,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: dream.getProgress() / 100,
                    backgroundColor: AppColors.carbonFiber,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      dream.getStatusColor(),
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Contributions list
          Expanded(
            child: contributionsState.when(
              data: (contributions) => ListView.builder(
                padding: const EdgeInsets.all(AppDimensions.space16),
                itemCount: contributions.length,
                itemBuilder: (context, index) {
                  final contribution = contributions[index];

                  return ContributionCard(
                    contribution: contribution,
                    onLike: () {
                      ref
                          .read(dreamContributionsProvider(widget.dreamId)
                              .notifier)
                          .likeContribution(contribution.id);
                    },
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('Error')),
            ),
          ),

          // Contribution input
          dreamState.when(
            data: (dream) => !dream.isFull()
                ? Container(
                    padding: const EdgeInsets.all(AppDimensions.space16),
                    decoration: const BoxDecoration(
                      color: AppColors.darkMatter,
                      border: Border(
                        top: BorderSide(
                          color: AppColors.carbonFiber,
                          width: 1,
                        ),
                      ),
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _contributionController,
                              maxLines: 3,
                              minLines: 1,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Add your part to the story...',
                                hintStyle: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                                filled: true,
                                fillColor: AppColors.glassLight,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send),
                            color: AppColors.cyberPurple,
                            onPressed: () {
                              if (_contributionController.text.isNotEmpty) {
                                ref
                                    .read(dreamContributionsProvider(
                                            widget.dreamId)
                                        .notifier)
                                    .addContribution(
                                        _contributionController.text);
                                _contributionController.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
