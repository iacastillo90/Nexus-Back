import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/feed_providers.dart';
import '../widgets/post_card.dart';
import '../widgets/comment_card.dart';

/// Post detail screen with comments
class PostDetailScreen extends ConsumerStatefulWidget {
  final String postId;

  const PostDetailScreen({
    super.key,
    required this.postId,
  });

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more comments when 200px from bottom
      ref
          .read(postDetailControllerProvider(widget.postId).notifier)
          .loadMoreComments();
    }
  }

  Future<void> _addComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    await ref
        .read(postDetailControllerProvider(widget.postId).notifier)
        .addComment(content);

    _commentController.clear();
    if (!mounted) return;
    FocusScope.of(context).unfocus();
  }

  Future<void> _onRefresh() async {
    await ref
        .read(postDetailControllerProvider(widget.postId).notifier)
        .refresh();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postDetailControllerProvider(widget.postId));

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Column(
        children: [
          // Post content and comments (scrollable)
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppColors.nexusBlue,
              backgroundColor: AppColors.darkMatter,
              child: state.isLoadingPost
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.nexusBlue,
                        ),
                      ),
                    )
                  : state.error != null
                      ? Center(
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
                                'Error loading post',
                                style: AppTypography.titleMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: AppDimensions.space8),
                              Text(
                                state.error!,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Post card
                              if (state.post != null)
                                PostCard(
                                  post: state.post!,
                                  onLike: () {
                                    ref
                                        .read(feedControllerProvider.notifier)
                                        .toggleLike(state.post!.id);
                                  },
                                  onBookmark: () {
                                    ref
                                        .read(feedControllerProvider.notifier)
                                        .toggleBookmark(state.post!.id);
                                  },
                                ),

                              const SizedBox(height: AppDimensions.space24),

                              // Comments header
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimensions.space16,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Comments',
                                      style:
                                          AppTypography.titleMedium.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: AppDimensions.space8),
                                    Text(
                                      '(${state.comments.length})',
                                      style: AppTypography.bodyMedium.copyWith(
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: AppDimensions.space16),

                              // Comments list
                              if (state.comments.isEmpty &&
                                  !state.isLoadingComments)
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      AppDimensions.space32,
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.chat_bubble_outline,
                                          size: 48,
                                          color: AppColors.textTertiary,
                                        ),
                                        const SizedBox(
                                          height: AppDimensions.space16,
                                        ),
                                        Text(
                                          'No comments yet',
                                          style:
                                              AppTypography.bodyMedium.copyWith(
                                            color: AppColors.textTertiary,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: AppDimensions.space8,
                                        ),
                                        Text(
                                          'Be the first to comment!',
                                          style:
                                              AppTypography.bodySmall.copyWith(
                                            color: AppColors.textTertiary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.comments.length +
                                      (state.hasMoreComments ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == state.comments.length) {
                                      // Loading indicator
                                      return const Padding(
                                        padding: EdgeInsets.all(
                                          AppDimensions.space16,
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              AppColors.nexusBlue,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    final comment = state.comments[index];

                                    return CommentCard(
                                      comment: comment,
                                      onLike: () {
                                        ref
                                            .read(postDetailControllerProvider(
                                                    widget.postId)
                                                .notifier)
                                            .toggleLikeComment(comment.id);
                                      },
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
            ),
          ),

          // Comment input
          Container(
            decoration: const BoxDecoration(
              color: AppColors.darkMatter,
              border: Border(
                top: BorderSide(
                  color: AppColors.carbonFiber,
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.only(
              left: AppDimensions.space16,
              right: AppDimensions.space16,
              top: AppDimensions.space12,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  AppDimensions.space12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMedium),
                        borderSide: const BorderSide(
                          color: AppColors.carbonFiber,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMedium),
                        borderSide: const BorderSide(
                          color: AppColors.carbonFiber,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMedium),
                        borderSide: const BorderSide(
                          color: AppColors.nexusBlue,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.space16,
                        vertical: AppDimensions.space12,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _addComment(),
                  ),
                ),
                const SizedBox(width: AppDimensions.space8),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.nexusBlue,
                  ),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
