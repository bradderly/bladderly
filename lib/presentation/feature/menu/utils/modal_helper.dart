import 'package:flutter/material.dart';

class ModalHelper {
  static void showModal(
    BuildContext context,
    Widget modalContent, {
    bool isScrollControlled = true,
    int duration = 1,
  }) {
    // ignore: inference_failure_on_function_invocation
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: Duration(seconds: duration),
      ),
      builder: (context) {
        return modalContent;
      },
    );
  }
}
