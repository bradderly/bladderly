import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/feature/passcode/change/model/passcode_change_status_model.dart';
import 'package:bladderly/presentation/feature/passcode/widget/passcode_dot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PasscodeChangeView extends StatefulWidget {
  const PasscodeChangeView({super.key});

  @override
  State<PasscodeChangeView> createState() => _PasscodeChangeViewState();
}

class _PasscodeChangeViewState extends State<PasscodeChangeView> {
  late final passcodeController = TextEditingController()..addListener(onTextEditingControllerListener);
  final focusNode = FocusNode();

  String newPasscode = '';
  PasscodeChangeStatusModel status = PasscodeChangeStatusModel.verification;
  bool isIncorrect = false;

  @override
  void dispose() {
    passcodeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void onTextEditingControllerListener() {
    return switch (status) {
      PasscodeChangeStatusModel.verification => onChangeOldPasscode(passcodeController.text),
      PasscodeChangeStatusModel.changing => onChangeNewPasscode(passcodeController.text),
      PasscodeChangeStatusModel.confirm => onChangeConfirmPasscode(passcodeController.text),
    };
  }

  void onChangeOldPasscode(String passcode) {
    if (passcode.trim().length != 4) {
      return;
    }

    final isCorrect = context.read<PasscodeCubit>().state.verifyPasscode(passcode);

    setState(() {
      if (isCorrect) status = PasscodeChangeStatusModel.changing;
      isIncorrect = !isCorrect;
    });

    passcodeController.clear();
  }

  void onChangeNewPasscode(String passcode) {
    if (passcode.trim().length != 4) {
      return;
    }

    setState(() {
      status = PasscodeChangeStatusModel.confirm;
      newPasscode = passcode;
    });

    passcodeController.clear();
  }

  void onChangeConfirmPasscode(String passcode) {
    if (passcode.trim().length != 4) {
      return;
    }

    final isCorrect = newPasscode == passcode;

    setState(() => isIncorrect = !isCorrect);

    if (!isCorrect) return passcodeController.clear();

    context
      ..read<PasscodeCubit>().lock(passcode: newPasscode)
      ..pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(title: 'Passcode'.tr(context)),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: focusNode.requestFocus,
            behavior: HitTestBehavior.translucent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  status.text.tr(context),
                  style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade6),
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
                SizedBox.shrink(
                  child: TextField(
                    focusNode: focusNode,
                    autofocus: true,
                    controller: passcodeController,
                    obscureText: true,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
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
