import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Karma ring avatar with circular progress indicator
class KarmaRingAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final double size;
  final double karmaScore; // 0.0 to 1.0

  const KarmaRingAvatar({
    super.key,
    this.imageUrl,
    required this.initials,
    this.size = 48.0,
    this.karmaScore = 0.0,
  });

  Color get _karmaColor {
    if (karmaScore >= 0.8) return AppColors.karmaVerified;
    if (karmaScore >= 0.5) return AppColors.karmaEstablished;
    if (karmaScore >= 0.3) return AppColors.karmaNewcomer;
    return AppColors.karmaSuspicious;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Karma ring (background)
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: karmaScore,
              strokeWidth: 3,
              backgroundColor: AppColors.carbonFiber,
              valueColor: AlwaysStoppedAnimation<Color>(_karmaColor),
            ),
          ),

          // Avatar
          Center(
            child: Container(
              width: size - 8,
              height: size - 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkMatter,
                image: imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imageUrl == null
                  ? Center(
                      child: Text(
                        initials,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: size * 0.35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
