// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalHelper {
  static void showModal<T extends BlocBase<Object?>>({
    required BuildContext context,
    required Widget Function(BuildContext context) modalBuilder,
    bool isScrollControlled = true,
    int duration = 1,
  }) {
    // ignore: inference_failure_on_function_invocation
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: modalBuilder,
    );
  }
}
