import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../domain/entities/mentor_entity.dart';

/// Mentor selector card widget
class MentorSelectorCard extends StatelessWidget {
  final MentorEntity mentor;
  final VoidCallback onTap;

  const MentorSelectorCard({
    super.key,
    required this.mentor,
    required this.onTap,
  });

  Color _getColor() {
    return Color(int.parse(mentor.colorHex.replaceFirst('#', '0xFF')));
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimensions.space12),
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
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color,
                    color.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  mentor.avatar,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),

            const SizedBox(width: AppDimensions.space16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        mentor.name,
                        style: AppTypography.titleMedium.copyWith(
                          color: color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (mentor.isOnline)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.karmaVerified,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.karmaVerified.withValues(alpha: 0.5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mentor.specialty,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    mentor.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Unread badge
            if (mentor.hasUnread)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${mentor.unreadCount}',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.voidBlack,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
