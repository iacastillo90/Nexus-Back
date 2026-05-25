import 'package:flutter/material.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../domain/entities/reality_layer_entity.dart';

/// Layer card widget for layer selector
class LayerCard extends StatelessWidget {
  final RealityLayerEntity layer;
  final VoidCallback onTap;
  final bool isSelected;

  const LayerCard({
    super.key,
    required this.layer,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: layer.getGradient(),
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          border: Border.all(
            color: isSelected
                ? layer.getColor()
                : layer.getColor().withValues(alpha: 0.3),
            width: isSelected ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: layer.getColor().withValues(alpha: 0.3),
              blurRadius: isSelected ? 16 : 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    layer.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.space12),

              // Name
              Text(
                layer.name,
                style: AppTypography.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              // Description
              Text(
                layer.description,
                style: AppTypography.bodySmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const Spacer(),

              // Post count
              if (layer.postCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${layer.postCount} posts',
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
