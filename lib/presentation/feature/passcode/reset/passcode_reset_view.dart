import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/passcode/widget/passcode_dot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PasscodeResetView extends StatefulWidget {
  const PasscodeResetView({
    super.key,
  });

  @override
  State<PasscodeResetView> createState() => _PasscodeResetViewState();
}

class _PasscodeResetViewState extends State<PasscodeResetView> with WidgetsBindingObserver {
  late final passcodeController = TextEditingController()..addListener(onTextEditingControllerListener);
  final focusNode = FocusNode();

  bool isIncorrect = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    focusNode.dispose();
    passcodeController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    return switch (state) {
      AppLifecycleState.resumed => focusNode.requestFocus(),
      AppLifecycleState.paused => focusNode.unfocus(),
      _ => null,
    };
  }

  void onTextEditingControllerListener() => onChangePasscode(passcodeController.text);

  void onChangePasscode(String passcode) {
    if (passcode.trim().length != 4) {
      return;
    }

    final isCorrect = context.read<PasscodeCubit>().state.passcode == passcode;

    setState(() => isIncorrect = !isCorrect);

    if (!isCorrect) return passcodeController.clear();

    context
      ..read<PasscodeCubit>().unlock()
      ..pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(title: 'Passcode'.tr(context)),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter your passcode'.tr(context),
                    style: context.textStyleTheme.b16Medium.copyWith(
                      color: context.colorTheme.neutral.shade6,
                    ),
                  ),
                  const Gap(20),
                  ListenableBuilder(
                    listenable: passcodeController,
                    builder: (_, __) => PasscodeDotWidget(count: passcodeController.text.length),
                  ),
                  const Gap(20),
                  if (isIncorrect)
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
                    focusNode: focusNode,
                    controller: passcodeController,
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
    );
  }
}
