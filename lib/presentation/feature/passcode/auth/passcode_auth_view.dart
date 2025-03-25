import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PasscodeAuthView extends StatefulWidget {
  const PasscodeAuthView({super.key});

  @override
  State<PasscodeAuthView> createState() => _PasscodeAuthViewState();
}

class _PasscodeAuthViewState extends State<PasscodeAuthView> with WidgetsBindingObserver {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool isUncorrect = false;

  int attemptCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    return switch (state) {
      AppLifecycleState.resumed => _focusNode.requestFocus(),
      AppLifecycleState.paused => _focusNode.unfocus(),
      _ => null,
    };
  }

  Future<void> onChangedPasscode(String passcode) async {
    if (passcode.length < 4) return;

    attemptCount++;

    final isCorrect = passcode == context.read<PasscodeCubit>().state.passcode;

    if (isCorrect) return const MainRoute().go(context);

    if (attemptCount == 5) {
      await CommonMessageModal.show<void>(
        context,
        onTap: context.pop,
        title: 'Passcode failed 5 times title',
        content: 'Passcode failed 5 times body',
      );
    }

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
    return Scaffold(
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
        child: SafeArea(
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
                child: Center(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enter your passcode'.tr(context),
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
                        ],
                      ),
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
