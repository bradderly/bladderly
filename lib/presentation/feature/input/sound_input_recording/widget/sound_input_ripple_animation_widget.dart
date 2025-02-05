import 'package:flutter/material.dart';

class RipplePainter extends CustomPainter {
  RipplePainter({
    required this.progress,
    required this.rippleColor,
    required this.rippleRadius,
    required this.rippleWidth,
  });
  final double progress;
  final Color rippleColor;
  final double rippleRadius;
  final double rippleWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = rippleColor.withValues(alpha: 1.0 - progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = rippleWidth;

    final radius = rippleRadius * progress;
    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class RippleEffect extends StatefulWidget {
  const RippleEffect({
    super.key,
    this.rippleRadius = 150.0,
    this.rippleColor = Colors.black,
    this.rippleWidth = 8.0,
    this.rippleRepeatCount = 10000,
  });
  final double rippleRadius;
  final Color rippleColor;
  final double rippleWidth;
  final int rippleRepeatCount;

  @override
  State<RippleEffect> createState() => _RippleEffectState();
}

class _RippleEffectState extends State<RippleEffect> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) => AnimationController(vsync: this, duration: const Duration(seconds: 3)));

    _animations = _controllers
        .map(
          (controller) =>
              Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        )
        .toList();

    startAnimation();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> startAnimation() async {
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(
        const Duration(milliseconds: 400) * i,
        () {
          if (mounted) {
            _controllers[i]
              ..forward()
              ..repeat();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        _controllers.length,
        (index) => AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return CustomPaint(
              painter: RipplePainter(
                progress: _animations[index].value,
                rippleColor: widget.rippleColor,
                rippleRadius: widget.rippleRadius,
                rippleWidth: widget.rippleWidth,
              ),
              child: const SizedBox.expand(),
            );
          },
        ),
      ),
    );
  }
}
