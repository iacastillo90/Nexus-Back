import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/post_entity.dart';
import 'karma_ring_avatar.dart';
import 'media_viewer.dart';

/// 🃏 **Tarjeta de Publicación (Widget)**
///
/// Componente visual principal del Feed.
/// Muestra contenido, autor y acciones sociales con efecto "Glassmorphism".
///
/// **Características:**
/// - Avatar con anillo de Karma.
/// - Visualización de medios (Imágenes/Video).
/// - Botones de interacción (Like, Comment, Share).
/// - Soporte para gestos (Tap para detalles).
class PostCard extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onBookmark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 🤖 AI Post Detection
    final isAI = post.realityLayer == 'digital' || post.username == 'NexusBot';
    
    // 🛡️ Content DNA Verification
    final isVerified = post.contentDNA != null;
    
    // Border Color Logic
    Color borderColor = Colors.transparent;
    if (isVerified) borderColor = AppColors.karmaVerified; // Green
    if (isAI) borderColor = AppColors.nexusBlue; // Cyan for AI
    
    // Background Gradient for AI
    final backgroundGradient = isAI 
      ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.nexusBlue.withValues(alpha: 0.15),
            Colors.transparent,
          ],
        )
      : null;

    return NexusCard(
      onTap: onTap,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.space16,
        vertical: AppDimensions.space8,
      ),
      padding: EdgeInsets.zero,
      // Custom decoration properties for NexusCard if it accepts them, 
      // otherwise we might need to wrap the content or modify NexusCard.
      // Assuming NexusCard allows some customization or we wrap the child.
      // Since NexusCard is a custom widget, let's assume we can't easily change its internal decoration 
      // without modifying it, but we can wrap the content or use a Container inside.
      // However, to get the border *on* the card, we might need to modify NexusCard or use a Container *around* it?
      // No, NexusCard likely has a border property or we can wrap it. 
      // Let's wrap the child in a Container that provides the visual cues if NexusCard is rigid.
      // BUT, to look good, the border should be on the card itself.
      // Let's assume for this refactor we use a Container with the same styling as NexusCard but with our custom properties,
      // OR we just use the child to render the effects if NexusCard is transparent.
      // Actually, looking at the previous code, NexusCard was used. 
      // Let's try to use a Container with BoxDecoration to simulate the "Cyberpunk" look directly here if needed,
      // or better, let's assume NexusCard is just a wrapper and we can put a Container inside.
      // Wait, if NexusCard provides the glass effect, we want to keep it.
      // Let's wrap the inner content in a Container that has the gradient.
      // For the border, we might need to wrap the NexusCard in a Container with a border if NexusCard doesn't support it.
      
      child: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          border: Border.all(color: borderColor.withValues(alpha: 0.5), width: isVerified || isAI ? 1.5 : 0),
          borderRadius: BorderRadius.circular(24), // Match NexusCard radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (Avatar + Username + Time)
            Padding(
              padding: const EdgeInsets.all(AppDimensions.space16),
              child: Row(
                children: [
                  KarmaRingAvatar(
                    imageUrl: post.userAvatar,
                    initials: _getInitials(post.username),
                    size: 48,
                    karmaScore: 0.7,
                  ),
                  const SizedBox(width: AppDimensions.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.username ?? 'Unknown User',
                              style: AppTypography.titleSmall.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            if (isVerified) ...[
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  context.push(
                                    '/verify/certificate',
                                    extra: {
                                      'contentDNA': post.contentDNA,
                                      'authorUsername': post.username ?? 'Unknown',
                                      'timestamp': post.createdAt.toIso8601String(),
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.verified,
                                  color: AppColors.karmaVerified, // Neon Green
                                  size: 16,
                                ),
                              ),
                            ],
                            if (isAI) ...[
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.nexusBlue.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppColors.nexusBlue.withValues(alpha: 0.5)),
                                ),
                                child: Text(
                                  'AI',
                                  style: AppTypography.labelSmall.copyWith(
                                    fontSize: 8,
                                    color: AppColors.nexusBlue,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          post.timeAgo,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      // ... existing modal bottom sheet code ...
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: AppColors.voidBlack,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.flag_outlined, color: AppColors.errorFlare),
                              title: const Text('Report Content', style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Content reported for review'),
                                    backgroundColor: AppColors.nexusBlue,
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.block_outlined, color: AppColors.textSecondary),
                              title: const Text('Block User', style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.space16,
              ),
              child: Text(
                post.content,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontFamily: isAI ? 'Courier' : null, // Monospace for AI
                ),
              ),
            ),

            // Media (if available)
            if (post.hasImages) ...[
              const SizedBox(height: AppDimensions.space12),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MediaViewer(
                        mediaUrls: post.mediaUrls!,
                        initialIndex: 0,
                        heroTag: 'post_image_${post.id}',
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                  child: Hero(
                    tag: 'post_image_${post.id}',
                    child: CachedNetworkImage(
                      imageUrl: post.mediaUrls!.first,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 250,
                        color: AppColors.shadowGrey,
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.nexusBlue,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 250,
                        color: AppColors.shadowGrey,
                        child: const Icon(
                          Icons.error_outline,
                          color: AppColors.errorFlare,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: AppDimensions.space12),

            // Actions (Like, Comment, Share, Bookmark)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.space8,
                vertical: AppDimensions.space8,
              ),
              child: Row(
                children: [
                  _ActionButton(
                    icon: post.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    label: PostEntity.formatCount(post.likesCount),
                    color: post.isLiked ? AppColors.holoRose : null,
                    onPressed: onLike,
                  ),

                  const SizedBox(width: AppDimensions.space8),

                  _ActionButton(
                    icon: Icons.chat_bubble_outline,
                    label: PostEntity.formatCount(post.commentsCount),
                    onPressed: onComment,
                  ),

                  const SizedBox(width: AppDimensions.space8),

                  _ActionButton(
                    icon: Icons.share_outlined,
                    label: PostEntity.formatCount(post.sharesCount),
                    onPressed: onShare,
                  ),

                  const Spacer(),

                  IconButton(
                    icon: Icon(
                      post.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: post.isBookmarked
                          ? AppColors.nexusBlue
                          : AppColors.textSecondary,
                    ),
                    onPressed: onBookmark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to safely get initials from username
  String _getInitials(String? username) {
    if (username == null || username.isEmpty) {
      return 'U';
    }
    if (username.length == 1) {
      return username.toUpperCase();
    }
    return username.substring(0, 2).toUpperCase();
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space8,
          vertical: AppDimensions.space8,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppDimensions.iconMedium,
              color: color ?? AppColors.textSecondary,
            ),
            const SizedBox(width: AppDimensions.space4),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: color ?? AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
