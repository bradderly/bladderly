import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalHelper {
  static void showModal<T extends BlocBase<Object?>>({
    required BuildContext context,
    required Widget modalContent,
    T? bloc, // Bloc을 받을 수 있도록 설정
    bool isScrollControlled = true,
    int duration = 1,
  }) {
    // ignore: inference_failure_on_function_invocation
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (context) {
        // Bloc이 있을 경우 BlocProvider.value로 감싸고, 없으면 그냥 modalContent 반환
        if (bloc != null) {
          return BlocProvider<T>.value(
            value: bloc,
            child: modalContent,
          );
        }
        return modalContent;
      },
    );
  }
}
