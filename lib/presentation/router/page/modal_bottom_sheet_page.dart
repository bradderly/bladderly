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
        builder: (context) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.05),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: switch (ModalRoute.of(context)!.settings) {
                final ModalBottomSheetPage page => page.child,
                _ => child,
              },
            ),
          ),
        ),
      );
}
