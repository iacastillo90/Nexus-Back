import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../domain/entities/message_entity.dart';

/// 💬 **Burbuja de Mensaje (Widget)**
///
/// Renderiza un mensaje individual en el chat.
/// Diferencia visualmente entre mensajes propios y ajenos.
///
/// **Características:**
/// - Estilo "Glass" para mensajes recibidos.
/// - Gradiente sólido para mensajes enviados.
/// - Indicadores de estado (Enviado, Leído).
/// - Formato de hora.
class MessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isOwn;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isOwn,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isOwn ? 64 : 16,
          right: isOwn ? 16 : 64,
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment:
              isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Message bubble
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.space16,
                vertical: AppDimensions.space12,
              ),
              decoration: BoxDecoration(
                gradient: isOwn
                    ? const LinearGradient(
                        colors: [
                          AppColors.nexusBlue,
                          Color(0xFF0099CC),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isOwn ? null : AppColors.glassLight,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppDimensions.radiusMedium),
                  topRight: const Radius.circular(AppDimensions.radiusMedium),
                  bottomLeft: Radius.circular(
                    isOwn ? AppDimensions.radiusMedium : 4,
                  ),
                  bottomRight: Radius.circular(
                    isOwn ? 4 : AppDimensions.radiusMedium,
                  ),
                ),
                border: isOwn
                    ? null
                    : Border.all(
                        color: AppColors.carbonFiber,
                        width: 1,
                      ),
                boxShadow: isOwn
                    ? [
                        BoxShadow(
                          color: AppColors.nexusBlue.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender name (for other messages)
                  if (!isOwn) ...[
                    Text(
                      message.senderName,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.nexusBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],

                  // Message content
                  Text(
                    message.content,
                    style: AppTypography.bodyMedium.copyWith(
                      color: isOwn
                          ? AppColors.textPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            // Time and status
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.formattedTime,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiary,
                    fontSize: 11,
                  ),
                ),
                if (isOwn) ...[
                  const SizedBox(width: 4),
                  Text(
                    message.statusIcon,
                    style: TextStyle(
                      fontSize: 12,
                      color: message.isRead
                          ? AppColors.nexusBlue
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
