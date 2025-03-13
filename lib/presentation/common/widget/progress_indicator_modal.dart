// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorModal extends StatelessWidget {
  const ProgressIndicatorModal._();

  static Future<void> show(
    BuildContext context, {
    bool removeAutoFocus = true,
    bool useRootNavigator = true,
  }) {
    if (removeAutoFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }

    return showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: false,
      builder: (context) => const ProgressIndicatorModal._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Center(child: CupertinoActivityIndicator()),
    );
  }
}
