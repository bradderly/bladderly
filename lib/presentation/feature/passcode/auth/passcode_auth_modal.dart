// ignore_for_file: use_build_context_synchronously

import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasscodeAuthView extends StatefulWidget {
  const PasscodeAuthView({super.key});

  @override
  State<PasscodeAuthView> createState() => _PasscodeAuthViewState();
}

class _PasscodeAuthViewState extends State<PasscodeAuthView> {
  final _controller = TextEditingController();

  bool isUncorrect = false;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void onChangedPasscode(String passcode) {
    if (passcode.length < 4) return;

    final isCorrect = passcode == context.read<PasscodeCubit>().state.passcode;

    if (isCorrect) return const MainRoute().go(context);

    _controller.clear();
    setState(() => isUncorrect = true);
  }

  Widget buildPasscodeDots(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < length ? context.colorTheme.neutral.shade6 : Colors.transparent,
            border: Border.all(color: context.colorTheme.neutral.shade6),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) => GestureDetector(
        onTap: () {},
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Text(
                  'Passcode'.tr(context),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: context.colorTheme.neutral.shade10,
                  ),
                ),
                const SizedBox(height: 173),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Set your passcode below'.tr(context),
                        style: context.textStyleTheme.b16Medium.copyWith(
                          color: context.colorTheme.neutral.shade6,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListenableBuilder(
                        listenable: _controller,
                        builder: (context, _) => buildPasscodeDots(_controller.text.length),
                      ),
                      const SizedBox(height: 20),
                      if (isUncorrect)
                        Text(
                          'The passcode you entered is incorrect.\nPlease try again.'.tr(context),
                          style: context.textStyleTheme.b14Medium.copyWith(
                            color: context.colorTheme.warning,
                          ),
                        ),
                      Opacity(
                        opacity: 0,
                        child: SizedBox.shrink(
                          child: TextField(
                            onChanged: onChangedPasscode,
                            controller: _controller,
                            autofocus: true,
                            obscureText: true,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
