import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../app/theme/app_typography.dart';

/// Dairesel seviye göstergesi widget'ı
///
/// CustomPainter ile çizilmiş dairesel ring, merkezde seviye numarası.
/// `level % 10` baz alınarak ilerleme oranı hesaplanır (her 10 level'da bir tam tur).
class LevelRing extends StatelessWidget {
  /// Seviye numarası
  final int level;

  /// Widget boyutu (genişlik ve yükseklik)
  final double size;

  /// Seviye etiketinin gösterilip gösterilmeyeceği
  final bool showLabel;

  const LevelRing({
    super.key,
    required this.level,
    this.size = 80,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (level % 10) / 10;
    final ringColor = Theme.of(context).colorScheme.primary;
    final bgColor = Theme.of(context).colorScheme.surfaceContainerHighest;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _RingPainter(
              progress: progress,
              ringColor: ringColor,
              bgColor: bgColor,
            ),
            child: Center(
              child: Text(
                '$level',
                style: AppTypography.headlineSmall.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: size * 0.35,
                ),
              ),
            ),
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 4),
          Text(
            'common.level'.tr(),
            style: AppTypography.labelMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color ringColor;
  final Color bgColor;

  _RingPainter({
    required this.progress,
    required this.ringColor,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = size.width * 0.1;
    final radius = (size.width - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      3.14159 * 2 * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.ringColor != ringColor ||
        oldDelegate.bgColor != bgColor;
  }
}
