// Flutter imports:
import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  const RippleButton({
    super.key,
    this.boxDecoration,
    this.onTap,
    this.isAlignCenter = true,
    required this.child,
  });

  final bool isAlignCenter;
  final VoidCallback? onTap;
  final BoxDecoration? boxDecoration;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final shape = switch (boxDecoration?.shape) {
      BoxShape.circle => const CircleBorder(),
      BoxShape.rectangle => RoundedRectangleBorder(borderRadius: boxDecoration?.borderRadius ?? BorderRadius.zero),
      _ => null,
    };

    return Material(
      shape: shape,
      color: boxDecoration?.color ?? Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        borderRadius: boxDecoration?.borderRadius as BorderRadius? ?? BorderRadius.zero,
        splashColor: Colors.black.withValues(alpha: 0.2),
        child: Container(
          alignment: isAlignCenter ? Alignment.center : null,
          decoration: boxDecoration?.copyWith(color: Colors.transparent),
          child: child,
        ),
      ),
    );
  }
}
