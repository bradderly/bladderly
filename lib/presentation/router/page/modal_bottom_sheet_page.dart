import 'package:flutter/material.dart';

class ModalBottomSheetPage<T> extends Page<T> {
  const ModalBottomSheetPage({required super.key, required this.child, this.useSafeArea = false});

  final bool useSafeArea;
  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
        settings: this,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useSafeArea: useSafeArea,
        builder: (context) => switch (ModalRoute.of(context)!.settings) {
          final ModalBottomSheetPage page => page.child,
          _ => child,
        },
      );
}
