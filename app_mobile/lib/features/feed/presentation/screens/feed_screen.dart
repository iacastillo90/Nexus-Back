import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/feed_providers.dart';
import '../widgets/post_card.dart';
import '../widgets/post_card_shimmer.dart';
import 'package:share_plus/share_plus.dart';

/// 📰 **Pantalla de Feed Principal**
///
/// Muestra el flujo infinito de publicaciones.
///
/// **Características:**
/// - Infinite Scroll (carga automática al llegar al final).
/// - Pull-to-Refresh.
/// - Manejo de estados (Loading, Error, Empty, Data).
/// - Navegación a detalles de post y creación.
class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 📜 **Listener de Scroll**
  ///
  /// Detecta cuando el usuario se acerca al final de la lista (200px)
  /// para disparar la carga de más posts.
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more when 200px from bottom
      ref.read(feedControllerProvider.notifier).loadMore();
    }
  }

  /// 🔄 **Refrescar Feed**
  Future<void> _onRefresh() async {
    await ref.read(feedControllerProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedControllerProvider);
    final hasMore = ref.read(feedControllerProvider.notifier).hasMore;

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
            'NEXUS',
            style: AppTypography.headlineMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.view_in_ar, color: AppColors.plasmaGreen),
            onPressed: () {
              context.push('/layers');
            },
            tooltip: 'Reality Layers',
          ),
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.nexusBlue),
            onPressed: () {
              context.push('/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.holoRose),
            onPressed: () {
              context.push('/notifications');
            },
          ),
        ],
      ),
      body: feedState.when(
        data: (posts) {
          if (posts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.hub_outlined,
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: AppDimensions.space16),
                  Text(
                    'No posts yet',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space8),
                  Text(
                    'Start following users to see their posts',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: AppColors.nexusBlue,
            backgroundColor: AppColors.darkMatter,
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              cacheExtent: 500, // Optimize scrolling by preloading items
              itemCount: posts.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  // Loading indicator at bottom
                  return const Padding(
                    padding: EdgeInsets.all(AppDimensions.space16),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.nexusBlue,
                        ),
                      ),
                    ),
                  );
                }

                final post = posts[index];

                return PostCard(
                  post: post,
                  onLike: () {
                    ref
                        .read(feedControllerProvider.notifier)
                        .toggleLike(post.id);
                  },
                  onComment: () {
                    context.push('/post/${post.id}');
                  },
                  onShare: () {
                    final shareText = '${post.username} on Nexus:\n\n${post.content}\n\nJoin the discussion on Nexus App!';
                    Share.share(shareText);
                  },
                  onBookmark: () {
                    ref
                        .read(feedControllerProvider.notifier)
                        .toggleBookmark(post.id);
                  },
                  onTap: () {
                    context.push('/post/${post.id}');
                  },
                );
              },
            ),
          );
        },
        loading: () => ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => const PostCardShimmer(),
        ),
        error: (error, stack) => Center(
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
                'Error loading feed',
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimensions.space8),
              Text(
                error.toString(),
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.space24),
              ElevatedButton(
                onPressed: _onRefresh,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/create-post');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
