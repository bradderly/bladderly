import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class PrimaryBackground extends StatelessWidget {
  const PrimaryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(decoration: BoxDecoration(color: context.colorTheme.neutral.shade0)),
        Positioned.fill(
          bottom: null,
          child: Container(
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.colorTheme.vermilion.primary.shade40,
                  context.colorTheme.vermilion.primary.shade40,
                  context.colorTheme.vermilion.primary.shade30.withValues(alpha: 0.3),
                  context.colorTheme.vermilion.primary.shade30.withAlpha(0),
                ],
                stops: const [0.0, 0.30, 0.81, 1],
              ),
            ),
          ),
        ),
        Positioned(
          top: 103 + 127,
          left: 46,
          child: CustomPaint(
            painter: CircleWithBlurPainter(
              color: context.colorTheme.vermilion.primary.shade50,
              radius: 103,
              bulrRadius: 50,
            ),
          ),
        ),
        Positioned(
          top: 375 + 203,
          left: 375 + 230,
          child: CustomPaint(
            painter: CircleWithBlurPainter(
              color: context.colorTheme.paleLime.shade60.withValues(alpha: 0.3),
              radius: 375,
              bulrRadius: 120,
            ),
          ),
        ),
        Positioned(
          top: 148.5 + 158,
          right: 148.5 + (93 - 168),
          child: CustomPaint(
            painter: CircleWithBlurPainter(
              color: context.colorTheme.vermilion.primary.shade30.withValues(alpha: 0.8),
              radius: 148.5,
              bulrRadius: 120,
            ),
          ),
        ),
      ],
    );
  }
}

class CircleWithBlurPainter extends CustomPainter {
  const CircleWithBlurPainter({
    super.repaint,
    required this.radius,
    required this.color,
    required this.bulrRadius,
  });

  final double radius;
  final Color color;
  final double bulrRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, bulrRadius);

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 정적 렌더링
  }
}
