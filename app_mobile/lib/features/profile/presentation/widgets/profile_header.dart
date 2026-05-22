import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../feed/presentation/widgets/karma_ring_avatar.dart';

/// 🖼️ **Encabezado de Perfil (Widget)**
///
/// Componente visual superior de la pantalla de perfil.
///
/// **Elementos:**
/// - Imagen de portada (Cover).
/// - Avatar con anillo de Karma superpuesto.
/// - Información básica (Nombre, Bio, Ubicación).
/// - Botón de acción principal (Editar/Seguir).
class ProfileHeader extends StatelessWidget {
  final String? coverImage;
  final String? avatar;
  final String username;
  final String? bio;
  final String? location;
  final String memberSince;
  final double karmaScore;
  final bool isCurrentUser;
  final bool isFollowing;
  final VoidCallback? onEditProfile;
  final VoidCallback? onToggleFollow;

  const ProfileHeader({
    super.key,
    this.coverImage,
    this.avatar,
    required this.username,
    this.bio,
    this.location,
    required this.memberSince,
    required this.karmaScore,
    this.isCurrentUser = false,
    this.isFollowing = false,
    this.onEditProfile,
    this.onToggleFollow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cover image
        Stack(
          children: [
            // Cover
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: coverImage == null
                    ? const LinearGradient(
                        colors: [
                          AppColors.nexusBlue,
                          AppColors.cyberPurple,
                        ],
                      )
                    : null,
              ),
              child: coverImage != null
                  ? CachedNetworkImage(
                      imageUrl: coverImage!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.nexusBlue,
                              AppColors.cyberPurple,
                            ],
                          ),
                        ),
                      ),
                    )
                  : null,
            ),

            // Avatar
            Positioned(
              bottom: -40,
              left: AppDimensions.space16,
              child: KarmaRingAvatar(
                imageUrl: avatar,
                initials: username.substring(0, 2).toUpperCase(),
                size: 100,
                karmaScore: karmaScore,
              ),
            ),
          ],
        ),

        const SizedBox(height: 50),

        // User info
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: AppTypography.headlineSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Member for $memberSince',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Action button
                  if (isCurrentUser)
                    OutlinedButton.icon(
                      onPressed: onEditProfile,
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Edit'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.nexusBlue,
                        side: const BorderSide(color: AppColors.nexusBlue),
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: onToggleFollow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFollowing
                            ? AppColors.carbonFiber
                            : AppColors.nexusBlue,
                      ),
                      child: Text(isFollowing ? 'Following' : 'Follow'),
                    ),
                ],
              ),

              if (bio != null) ...[
                const SizedBox(height: AppDimensions.space12),
                Text(
                  bio!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],

              if (location != null) ...[
                const SizedBox(height: AppDimensions.space8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
