import 'package:flutter/material.dart';

class ModalBottomSheetPage<T> extends Page<T> {
  const ModalBottomSheetPage({
    required super.key,
    required this.child,
  });

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
        settings: this,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => (ModalRoute.of(context)!.settings as ModalBottomSheetPage).child,
      );
}
