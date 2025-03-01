// Flutter imports:
import 'package:flutter/material.dart';

class CommonModal extends StatelessWidget {
  const CommonModal({
    super.key,
    required this.child,
  });

  final Widget child;

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CommonModal(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width - 48,
          child: child,
        ),
      ),
    );
  }
}
