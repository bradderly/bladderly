// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorModal extends StatelessWidget {
  const ProgressIndicatorModal._();

  static Future<void> show(
    BuildContext context, {
    bool removeAutoFocus = true,
  }) {
    if (removeAutoFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ProgressIndicatorModal._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CupertinoActivityIndicator());
  }
}
