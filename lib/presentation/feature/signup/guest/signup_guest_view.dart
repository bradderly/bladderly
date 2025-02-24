import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/common/widget/common_keyboard_actions.dart';
import 'package:bradderly/presentation/common/widget/primary_button.dart';
import 'package:bradderly/presentation/feature/signup/guest/cubit/signup_guest_form_cubit.dart';
import 'package:bradderly/presentation/feature/signup/guest/widget/signup_guest_field_widget.dart';
import 'package:bradderly/presentation/feature/signup/guest/widget/signup_guest_header_widget.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignupGuestView extends StatefulWidget {
  const SignupGuestView({super.key});

  @override
  State<SignupGuestView> createState() => _SignupGuestViewState();
}

class _SignupGuestViewState extends State<SignupGuestView> {
  final yearOfBirthFocusNode = FocusNode(debugLabel: 'yearOfBirthFocusNode');

  @override
  void dispose() {
    yearOfBirthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 77,
        leading: IconButton(
          onPressed: context.pop,
          icon: Assets.icon.icCommonArrowBack.svg(),
        ),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            CommonKeyboardActions(
              focusNode: yearOfBirthFocusNode,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 32),
                physics: const ClampingScrollPhysics(),
                children: [
                  const SignupGuestHeaderWidget(),
                  const Gap(64),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SignupGuestFieldWidget(
                        text: 'Sex'.tr(context),
                        child: BlocSelector<SignupGuestFormCubit, SignupGuestFormState, Sex?>(
                          selector: (state) => state.sex,
                          builder: (context, selectedSex) => Row(
                            children: List.generate(
                              Sex.values.length * 2 - 1,
                              (index) {
                                if (index.isOdd) return const Gap(16);

                                final sex = Sex.values[index ~/ 2];
                                final isSelected = sex == selectedSex;

                                return Expanded(
                                  child: PrimaryButton.outlined(
                                    onPressed: () => context.read<SignupGuestFormCubit>().setSex(sex),
                                    borderWidth: 3,
                                    borderColor: isSelected
                                        ? context.colorTheme.vermilion.secondary.shade20
                                        : context.colorTheme.neutral.shade3,
                                    backgroundColor: isSelected
                                        ? context.colorTheme.vermilion.secondary.shade10
                                        : context.colorTheme.neutral.shade3,
                                    borderRadius: 100,
                                    shape: BoxShape.rectangle,
                                    text: sex.text.tr(context),
                                    textColor: isSelected
                                        ? context.colorTheme.vermilion.secondary.shade40
                                        : context.colorTheme.neutral.shade6,
                                    size: const Size.fromHeight(43),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const Gap(32),
                      SignupGuestFieldWidget(
                        text: 'Year of Birth'.tr(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.colorTheme.neutral.shade2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            onChanged: context.read<SignupGuestFormCubit>().setYearOfBirth,
                            focusNode: yearOfBirthFocusNode,
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildGetStartedButton(context),
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
            : BlocSelector<SignupGuestFormCubit, SignupGuestFormState, bool>(
                selector: (state) => state.isValid,
                builder: (context, isValid) => PrimaryButton.filled(
                  onPressed: () {},
                  backgroundColor:
                      isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
                  borderRadius: 400,
                  shape: BoxShape.rectangle,
                  text: 'Get started'.tr(context),
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size.fromHeight(56),
                ),
              ),
      ),
    );
  }
}
