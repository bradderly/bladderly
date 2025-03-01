import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/widget/common_keyboard_actions.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/feature/sign_up/cubit/sign_up_required_info_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_up/widget/sign_up_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';

class SignUpRequiredInfoView extends StatefulWidget {
  const SignUpRequiredInfoView({
    super.key,
    required this.yearOfBirthFocusNode,
    required this.onSubmit,
  });

  final FocusNode yearOfBirthFocusNode;
  final void Function(SignUpRequiredInfoFormState) onSubmit;

  @override
  State<SignUpRequiredInfoView> createState() => _SignUpRequiredInfoViewState();
}

class _SignUpRequiredInfoViewState extends State<SignUpRequiredInfoView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        CommonKeyboardActions(
          focusNode: widget.yearOfBirthFocusNode,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 28, bottom: 32),
            physics: const ClampingScrollPhysics(),
            children: [
              const _SignUpGuestHeaderWidget(),
              const Gap(64),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSexInputField(context),
                  const Gap(32),
                  _buildYearOfBirthInputField(context),
                ],
              ),
            ],
          ),
        ),
        _buildGetStartedButton(context),
      ],
    );
  }

  Widget _buildSexInputField(BuildContext context) {
    return SignUpFieldWidget(
      text: 'Sex'.tr(context),
      child: BlocSelector<SignUpRequiredInfoFormCubit, SignUpRequiredInfoFormState, Gender?>(
        selector: (state) => state.gender,
        builder: (context, selectedSex) => Row(
          children: List.generate(
            Gender.values.length * 2 - 1,
            (index) {
              if (index.isOdd) return const Gap(16);

              final sex = Gender.values[index ~/ 2];
              final isSelected = sex == selectedSex;

              return Expanded(
                child: PrimaryButton.outlined(
                  onPressed: () => context.read<SignUpRequiredInfoFormCubit>().setGender(sex),
                  borderWidth: 3,
                  borderColor:
                      isSelected ? context.colorTheme.vermilion.secondary.shade20 : context.colorTheme.neutral.shade3,
                  backgroundColor:
                      isSelected ? context.colorTheme.vermilion.secondary.shade10 : context.colorTheme.neutral.shade3,
                  borderRadius: 100,
                  shape: BoxShape.rectangle,
                  text: sex.text.tr(context),
                  textColor:
                      isSelected ? context.colorTheme.vermilion.secondary.shade40 : context.colorTheme.neutral.shade6,
                  size: const Size.fromHeight(43),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildYearOfBirthInputField(BuildContext context) {
    return SignUpFieldWidget(
      text: 'Year of Birth'.tr(context),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorTheme.neutral.shade2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          onChanged: context.read<SignUpRequiredInfoFormCubit>().setYearOfBirth,
          focusNode: widget.yearOfBirthFocusNode,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
            isDense: false,
          ),
          style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
          keyboardType: TextInputType.number,
          inputFormatters: [
            TextInputFormatter.withFunction((oldValue, newValue) {
              final year = int.tryParse(newValue.text);

              if (year == null) return newValue;

              if (year > DateTime.now().year) return oldValue;

              return newValue;
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Positioned.fill(
      top: null,
      left: 24,
      right: 24,
      bottom: 28,
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => isKeyboardVisible
            ? const SizedBox.shrink()
            : BlocSelector<SignUpRequiredInfoFormCubit, SignUpRequiredInfoFormState, bool>(
                selector: (state) => state.isValid,
                builder: (context, isValid) => PrimaryButton.filled(
                  onPressed: isValid ? () => widget.onSubmit(context.read<SignUpRequiredInfoFormCubit>().state) : null,
                  backgroundColor:
                      isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
                  borderRadius: 400,
                  shape: BoxShape.rectangle,
                  text: 'Get Started'.tr(context),
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size.fromHeight(56),
                ),
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SignUpGuestHeaderWidget extends StatelessWidget {
  const _SignUpGuestHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You’re not alone.'.tr(context),
          style: context.textStyleTheme.b24Bold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        const Gap(24),
        Text(
          'Let’s take it step by step together to better days.'.tr(context),
          style: context.textStyleTheme.b16Medium.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
        Gap(
          switch (context.locale) {
            AppLocale.en => 16,
            AppLocale.ko => 8,
          },
        ),
        Text(
          'First, we’d like to get to know you.'.tr(context),
          style: context.textStyleTheme.b16Medium.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
        ),
      ],
    );
  }
}
