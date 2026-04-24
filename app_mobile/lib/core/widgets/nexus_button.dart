import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimensions.dart';
import '../../app/theme/app_typography.dart';

/// 🔘 **NexusButton**
///
/// Botón principal con estilo Cyberpunk.
/// Soporta variantes: Primary (Neon), Secondary (Outline), Ghost (Text).
enum NexusButtonType { primary, secondary, ghost, danger }

class NexusButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final NexusButtonType type;
  final IconData? icon;
  final bool isLoading;
  final double? width;

  const NexusButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = NexusButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Definir estilos según el tipo
    Color backgroundColor;
    Color foregroundColor;
    BorderSide? borderSide;
    List<BoxShadow> shadows = [];

    switch (type) {
      case NexusButtonType.primary:
        backgroundColor = AppColors.nexusBlue;
        foregroundColor = AppColors.voidBlack;
        shadows = AppColors.neonGlow;
        break;
      case NexusButtonType.secondary:
        backgroundColor = Colors.transparent;
        foregroundColor = AppColors.nexusBlue;
        borderSide = const BorderSide(color: AppColors.nexusBlue, width: 1.5);
        break;
      case NexusButtonType.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = AppColors.textSecondary;
        break;
      case NexusButtonType.danger:
        backgroundColor = AppColors.errorFlare;
        foregroundColor = Colors.white;
        shadows = [
          BoxShadow(
            color: AppColors.errorFlare.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ];
        break;
    }

    // Deshabilitado
    if (onPressed == null) {
      backgroundColor = AppColors.darkMatter;
      foregroundColor = AppColors.textDisabled;
      shadows = [];
      borderSide = null;
    }

    return Container(
      width: width,
      decoration: BoxDecoration(
        boxShadow: onPressed != null ? shadows : [],
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0, // Sombra manejada por Container
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space24,
            vertical: AppDimensions.space16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            side: borderSide ?? BorderSide.none,
          ),
          textStyle: AppTypography.labelLarge,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: AppDimensions.space8),
                  ],
                  Text(text),
                ],
              ),
      ),
    );
  }
}
