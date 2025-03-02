// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/sign_up/cubit/sign_up_additional_info_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/widget/sign_up_field_widget.dart';

class SignUpAdditionalInfoView extends StatelessWidget {
  const SignUpAdditionalInfoView({super.key, required this.onSubmit});

  final void Function(SignUpAdditionalInfoFormState) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 28, bottom: 32),
          physics: const ClampingScrollPhysics(),
          children: [
            Text(
              'Tell us about you!'.tr(context),
              style: context.textStyleTheme.b24Bold.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
            ),
            const Gap(100),
            SignUpFieldWidget(
              text: 'What would like me to call you?'.tr(context),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: context.read<SignUpAdditionalInfoFormCubit>().setUserName,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
                    isDense: false,
                    hintText: 'Bladderly User'.tr(context),
                    hintStyle: TextStyle(color: context.colorTheme.neutral.shade7),
                  ),
                  style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                ),
              ),
            ),
            const Gap(48),
            SignUpFieldWidget(
              text: 'Any diagnosed disease?'.tr(context),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: context.read<SignUpAdditionalInfoFormCubit>().setDisease,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
                    isDense: false,
                    hintText: 'Not to answer'.tr(context),
                    hintStyle: TextStyle(color: context.colorTheme.neutral.shade7),
                  ),
                  style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                ),
              ),
            ),
          ],
        ),
        _buildDoneButton(context),
      ],
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return Positioned.fill(
      top: null,
      left: 24,
      right: 24,
      bottom: 28,
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => isKeyboardVisible
            ? const SizedBox.shrink()
            : PrimaryButton.filled(
                onPressed: () => onSubmit(context.read<SignUpAdditionalInfoFormCubit>().state),
                backgroundColor: context.colorTheme.vermilion.primary.shade50,
                borderRadius: 400,
                shape: BoxShape.rectangle,
                text: 'Done'.tr(context),
                textColor: context.colorTheme.neutral.shade0,
                size: const Size.fromHeight(56),
              ),
      ),
    );
  }
}
