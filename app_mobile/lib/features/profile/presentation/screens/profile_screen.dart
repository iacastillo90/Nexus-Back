import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class ProfileScreen extends ConsumerWidget {
  final String? userId;

  const ProfileScreen({
    this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authControllerProvider).value;
    final isMe = userId == null || userId == 'me' || (currentUser != null && userId == currentUser.id);

    if (currentUser == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(isMe ? 'My Profile' : 'Profile'),
        actions: [
          if (isMe)
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.push('/profile/settings'),
            ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Gradient
            Container(
              height: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.nexusBlue.withValues(alpha: 0.2),
                    AppColors.voidBlack,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Karma Ring Avatar (Placeholder)
                    GestureDetector(
                      onTap: () {
                        // Mock Karma Entity for now (since backend might not return full object yet)
                        // In real implementation, pass the actual entity from the provider
                        /*
                        context.push(
                          '/profile/karma',
                          extra: currentUser.karma, // Assuming user has karma field
                        );
                        */
                        // For demo:
                        context.push('/profile/karma');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.nexusBlue,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.nexusBlue.withValues(alpha: 0.5),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.deepSpace,
                          child: Icon(Icons.person, size: 50, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentUser.username,
                      style: AppTypography.headlineMedium.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.nexusBlue.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.nexusBlue.withValues(alpha: 0.5)),
                      ),
                      child: Text(
                        'ARCHITECT', // Placeholder Tier
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.nexusBlue,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Karma', '1,240'),
                  _buildStatItem('Posts', '42'),
                  _buildStatItem('Following', '128'),
                  _buildStatItem('Followers', '356'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Content Tabs (Placeholder)
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: AppColors.nexusBlue,
                    labelColor: AppColors.nexusBlue,
                    unselectedLabelColor: AppColors.textSecondary,
                    tabs: [
                      Tab(text: 'Posts'),
                      Tab(text: 'Media'),
                      Tab(text: 'Likes'),
                    ],
                  ),
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      children: [
                        _buildPlaceholderTab('No posts yet'),
                        _buildPlaceholderTab('No media yet'),
                        _buildPlaceholderTab('No likes yet'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.titleLarge.copyWith(color: Colors.white),
        ),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildPlaceholderTab(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.layers_outlined, size: 48, color: AppColors.textTertiary),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
