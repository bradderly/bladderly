import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorModal extends StatelessWidget {
  const ProgressIndicatorModal({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ProgressIndicatorModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CupertinoActivityIndicator());
  }
}
