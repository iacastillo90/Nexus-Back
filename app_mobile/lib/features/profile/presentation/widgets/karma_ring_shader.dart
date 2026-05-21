import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../app/theme/app_colors.dart';

/// Karma ring shader widget with CustomPainter
class KarmaRingShader extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final String tier;

  const KarmaRingShader({
    super.key,
    required this.progress,
    this.size = 120,
    this.strokeWidth = 8,
    this.tier = 'newcomer',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _KarmaRingPainter(
          progress: progress,
          strokeWidth: strokeWidth,
          tier: tier,
        ),
      ),
    );
  }
}

class _KarmaRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final String tier;

  _KarmaRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.tier,
  });

  Color _getTierStartColor() {
    switch (tier.toLowerCase()) {
      case 'legendary':
        return const Color(0xFFFFD700); // Gold
      case 'verified':
        return AppColors.karmaVerified;
      case 'established':
        return AppColors.nexusBlue;
      case 'newcomer':
        return AppColors.cyberPurple;
      case 'suspicious':
        return AppColors.karmaSuspicious;
      default:
        return AppColors.textTertiary;
    }
  }

  Color _getTierEndColor() {
    switch (tier.toLowerCase()) {
      case 'legendary':
        return const Color(0xFFFFA500); // Orange
      case 'verified':
        return AppColors.nexusBlue;
      case 'established':
        return AppColors.cyberPurple;
      case 'newcomer':
        return AppColors.neonPink;
      case 'suspicious':
        return AppColors.errorFlare;
      default:
        return AppColors.carbonFiber;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..color = AppColors.carbonFiber
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc with gradient
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);

      final gradient = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: -math.pi / 2 + (2 * math.pi * progress),
        colors: [
          _getTierStartColor(),
          _getTierEndColor(),
        ],
        stops: const [0.0, 1.0],
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      // Draw arc from top (-90 degrees)
      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );

      // Glow effect
      final glowPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 4
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _KarmaRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.tier != tier;
  }
}
