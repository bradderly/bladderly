// Flutter imports:
import 'package:flutter/material.dart';

class ModalHelper {
  static Future<T?> showModal<T>({
    required BuildContext context,
    required Widget Function(BuildContext context) modalBuilder,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: modalBuilder,
      transitionAnimationController: AnimationController(
        duration: const Duration(milliseconds: 5000), // 애니메이션 시간 조정 (500ms)
        vsync: Navigator.of(context),
      ),
    );
  }
}
