import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/geo_post_entity.dart';

class ARPostCard extends StatelessWidget {
  final GeoPostEntity post;
  final VoidCallback? onTap;

  const ARPostCard({
    super.key,
    required this.post,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine style based on post type
    final isAI = post.realityLayer == 'digital' || post.authorName == 'NexusBot';
    final isVerified = post.contentDNA != null; // Assuming presence means verified for now

    Color borderColor;
    IconData icon;
    String label;
    List<BoxShadow> glow;

    if (isVerified) {
      borderColor = AppColors.karmaVerified;
      icon = Icons.verified_user;
      label = 'VERIFIED';
      glow = [
        BoxShadow(
          color: AppColors.karmaVerified.withValues(alpha: 0.4),
          blurRadius: 12,
          spreadRadius: 2,
        )
      ];
    } else if (isAI) {
      borderColor = AppColors.nexusBlue;
      icon = Icons.smart_toy;
      label = 'AI CONSTRUCT';
      glow = [
        BoxShadow(
          color: AppColors.nexusBlue.withValues(alpha: 0.4),
          blurRadius: 12,
          spreadRadius: 2,
        )
      ];
    } else {
      borderColor = AppColors.karmaSuspicious; // Or Orange
      icon = Icons.warning_amber_rounded;
      label = 'UNVERIFIED';
      glow = [
        BoxShadow(
          color: AppColors.karmaSuspicious.withValues(alpha: 0.2),
          blurRadius: 8,
          spreadRadius: 1,
        )
      ];
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.voidBlack.withValues(alpha: 0.7), // Glass effect base
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: glow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(icon, color: borderColor, size: 14),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: AppTypography.labelSmall.copyWith(
                    color: borderColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Content
            Text(
              post.content,
              style: AppTypography.bodySmall.copyWith(
                color: Colors.white,
                fontFamily: isAI ? 'Courier' : null,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            // Author
            Row(
              children: [
                CircleAvatar(
                  radius: 8,
                  backgroundImage: post.authorAvatar != null ? NetworkImage(post.authorAvatar!) : null,
                  backgroundColor: AppColors.glassLight,
                  child: post.authorAvatar == null 
                      ? Text(
                          post.authorName.isNotEmpty ? post.authorName[0].toUpperCase() : 'U', 
                          style: const TextStyle(fontSize: 10, color: Colors.white)
                        ) 
                      : null,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    post.authorName,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
