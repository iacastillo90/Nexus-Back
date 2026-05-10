import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/dreams_providers.dart';
import '../widgets/dream_card.dart';
import '../../domain/entities/dream_entity.dart';

/// Dreams list screen with active dreams grid
class DreamsListScreen extends ConsumerStatefulWidget {
  const DreamsListScreen({super.key});

  @override
  ConsumerState<DreamsListScreen> createState() => _DreamsListScreenState();
}

class _DreamsListScreenState extends ConsumerState<DreamsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.cyberPurple,
              AppColors.neonPink,
            ],
          ).createShader(bounds),
          child: Text(
            'Collective Dreams',
            style: AppTypography.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // Navigate to create dream screen
              // context.push('/dreams/create');
            },
            tooltip: 'Create Dream',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.cyberPurple,
          labelColor: AppColors.cyberPurple,
          unselectedLabelColor: AppColors.textTertiary,
          labelStyle: AppTypography.labelMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'All'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDreamsList(DreamStatus.active),
          _buildDreamsList(DreamStatus.completed),
          _buildDreamsList(null),
        ],
      ),
    );
  }

  Widget _buildDreamsList(DreamStatus? status) {
    final dreamsState = ref.watch(dreamsListProvider(status: status));

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(dreamsListProvider(status: status).notifier).refresh();
      },
      color: AppColors.cyberPurple,
      backgroundColor: AppColors.darkMatter,
      child: dreamsState.when(
        data: (dreams) {
          if (dreams.isEmpty) {
            return _buildEmptyState(status);
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppDimensions.space16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: AppDimensions.space12,
              mainAxisSpacing: AppDimensions.space12,
            ),
            itemCount: dreams.length,
            itemBuilder: (context, index) {
              final dream = dreams[index];

              return DreamCard(
                dream: dream,
                onTap: () {
                  // Navigate to dream detail
                  // context.push('/dreams/${dream.id}');
                },
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.cyberPurple),
          ),
        ),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.errorFlare,
              ),
              const SizedBox(height: AppDimensions.space16),
              Text(
                'Error loading dreams',
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(DreamStatus? status) {
    String message;
    if (status == DreamStatus.active) {
      message = 'No active dreams yet';
    } else if (status == DreamStatus.completed) {
      message = 'No completed dreams yet';
    } else {
      message = 'No dreams yet';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.nightlight_round,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppDimensions.space16),
          Text(
            message,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.space8),
          Text(
            'Start a collaborative story!',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
