import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  const DialogPage({
    required this.child,
    this.anchorPoint,
    this.barrierColor = Colors.black87,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute(
      context: context,
      settings: this,
      builder: (context) => PopScope(
        canPop: barrierDismissible,
        child: child,
      ),
      anchorPoint: anchorPoint,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      themes: themes,
    );
  }
}
