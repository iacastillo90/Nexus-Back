import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/geo_post_entity.dart';
import '../../data/datasources/layer_datasource.dart';

/// Geo post marker widget with pulsating animation
class GeoPostMarker extends StatefulWidget {
  final GeoPostEntity post;
  final VoidCallback onTap;

  const GeoPostMarker({
    super.key,
    required this.post,
    required this.onTap,
  });

  @override
  State<GeoPostMarker> createState() => _GeoPostMarkerState();
}

class _GeoPostMarkerState extends State<GeoPostMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getLayerColor() {
    final layer = LayerDataSource().getLayerById(widget.post.realityLayer);
    if (layer != null) {
      return layer.getColor();
    }
    return AppColors.nexusBlue;
  }

  @override
  Widget build(BuildContext context) {
    final layerColor = _getLayerColor();

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulsating glow
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                width: 40 * _pulseAnimation.value,
                height: 40 * _pulseAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: layerColor.withValues(alpha: 0.2 / _pulseAnimation.value),
                ),
              );
            },
          ),

          // Main marker
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  layerColor,
                  layerColor.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: layerColor.withValues(alpha: 0.5),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.place,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // Distance badge (if available)
          if (widget.post.distance != null)
            Positioned(
              bottom: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkMatter,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: layerColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.post.distance! < 1
                      ? '${(widget.post.distance! * 1000).round()}m'
                      : '${widget.post.distance!.toStringAsFixed(1)}km',
                  style: AppTypography.labelSmall.copyWith(
                    color: layerColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
