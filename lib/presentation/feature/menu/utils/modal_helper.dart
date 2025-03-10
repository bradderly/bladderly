// Flutter imports:
import 'package:flutter/material.dart';

class ModalHelper {
  static Future<void> showModal({
    required BuildContext context,
    required Widget Function(BuildContext context) modalBuilder,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: modalBuilder,
    );
  }
}
