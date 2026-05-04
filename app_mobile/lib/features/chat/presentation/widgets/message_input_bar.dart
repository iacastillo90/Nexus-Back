import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Message input bar widget
class MessageInputBar extends StatefulWidget {
  final Function(String) onSend;
  final VoidCallback? onTyping;

  const MessageInputBar({
    super.key,
    required this.onSend,
    this.onTyping,
  });

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() {
          _hasText = hasText;
        });
      }

      // Trigger typing indicator
      if (hasText && widget.onTyping != null) {
        widget.onTyping!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.space12),
      decoration: const BoxDecoration(
        color: AppColors.darkMatter,
        border: Border(
          top: BorderSide(
            color: AppColors.carbonFiber,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Voice button (placeholder)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.glassLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.carbonFiber,
                  width: 1,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.mic_none,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  // TODO: Implement voice input
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Voice input coming soon'),
                      backgroundColor: AppColors.nexusBlue,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: AppDimensions.space12),

            // Text input
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.glassLight,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusMedium,
                  ),
                  border: Border.all(
                    color: AppColors.carbonFiber,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ask your mentor...',
                    hintStyle: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.space16,
                      vertical: AppDimensions.space12,
                    ),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
            ),

            const SizedBox(width: AppDimensions.space12),

            // Send button
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: _hasText
                    ? const LinearGradient(
                        colors: [
                          AppColors.nexusBlue,
                          Color(0xFF0099CC),
                        ],
                      )
                    : null,
                color: _hasText ? null : AppColors.glassLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _hasText
                      ? AppColors.nexusBlue
                      : AppColors.carbonFiber,
                  width: 1,
                ),
                boxShadow: _hasText
                    ? [
                        BoxShadow(
                          color: AppColors.nexusBlue.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  size: 20,
                  color: _hasText
                      ? AppColors.textPrimary
                      : AppColors.textTertiary,
                ),
                onPressed: _hasText ? _handleSend : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
