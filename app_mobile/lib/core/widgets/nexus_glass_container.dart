import 'dart:ui';
import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimensions.dart';

/// 💎 **NexusGlassContainer**
///
/// Contenedor base para el sistema de diseño "Organic Cyberpunk".
/// Aplica efecto de vidrio esmerilado (frosted glass) con bordes de neón sutiles.
///
/// **Características:**
/// - Blur de fondo (sigmaX/Y)
/// - Borde con gradiente o color sólido
/// - Fondo semitransparente
/// - Sombra sutil para profundidad
class NexusGlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double blurAmount;
  final VoidCallback? onTap;
  final bool isInteractive;

  const NexusGlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(AppDimensions.space16),
    this.margin,
    this.borderRadius = AppDimensions.radiusLarge,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.blurAmount = 10.0,
    this.onTap,
    this.isInteractive = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? AppColors.glassMedium;
    final effectiveBorderColor = borderColor ?? Colors.white.withValues(alpha: 0.1);

    Widget container = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: effectiveBorderColor,
              width: borderWidth,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                effectiveBackgroundColor,
                effectiveBackgroundColor.withValues(alpha: 0.1),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );

    if (margin != null) {
      container = Padding(padding: margin!, child: container);
    }

    if (onTap != null || isInteractive) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: AppColors.nexusBlue.withValues(alpha: 0.2),
          highlightColor: AppColors.nexusBlue.withValues(alpha: 0.1),
          child: container,
        ),
      );
    }

    return container;
  }
}
