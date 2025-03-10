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
    );
  }
}
