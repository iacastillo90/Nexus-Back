import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimensions.dart';
import 'nexus_glass_container.dart';

/// 🃏 **NexusCard**
///
/// Tarjeta estándar para el feed y listas.
/// Extiende [NexusGlassContainer] pero con defaults específicos para tarjetas de contenido.
class NexusCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool highlight;

  final Color? borderColor;

  const NexusCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppDimensions.space16),
    this.margin = const EdgeInsets.only(bottom: AppDimensions.space16),
    this.highlight = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return NexusGlassContainer(
      margin: margin,
      padding: padding,
      onTap: onTap,
      isInteractive: onTap != null,
      backgroundColor: AppColors.darkMatter.withValues(alpha: 0.7),
      borderColor: borderColor ?? (highlight ? AppColors.nexusBlue.withValues(alpha: 0.5) : null),
      borderWidth: highlight ? 1.5 : 1.0,
      child: child,
    );
  }
}
