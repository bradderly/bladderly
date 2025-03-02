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
import 'package:bladderly/presentation/feature/sign_in/widget/sign_in_field_widget.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/cubit/sign_up_regular_form_cubit.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

class SignUpRegularAccountInfoView extends StatefulWidget {
  const SignUpRegularAccountInfoView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<SignUpRegularAccountInfoView> createState() => _SignUpRegularAccountInfoViewState();
}

class _SignUpRegularAccountInfoViewState extends State<SignUpRegularAccountInfoView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 28, bottom: 112),
          children: [
            Text(
              'Sign up'.tr(context),
              style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
            ),
            const Gap(24),
            Text(
              'It’s free, secure and easy.\nWe will save your data safely.'.tr(context),
              style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
            ),
            const Gap(44),
            SignInFieldWidget(
              text: 'Email Address'.tr(context),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: (value) => context.read<SignUpRegularFormCubit>().setEmail(value),
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
                    isDense: false,
                  ),
                  style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            const Gap(24),
            SignInFieldWidget(
              text: 'Password'.tr(context),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BlocSelector<SignUpRegularFormCubit, SignUpRegularFormState, bool>(
                  selector: (state) => state.obsecurePassword,
                  builder: (_, obsecurePassword) => TextField(
                    onChanged: (value) => context.read<SignUpRegularFormCubit>().setPassword(value),
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
                      isDense: false,
                      suffixIcon: GestureDetector(
                        onTap: context.read<SignUpRegularFormCubit>().toggleObsecurePassword,
                        child: Icon(
                          obsecurePassword ? Icons.visibility : Icons.visibility_off,
                          size: 24,
                          color: context.colorTheme.neutral.shade6,
                        ),
                      ),
                    ),
                    style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: obsecurePassword,
                  ),
                ),
              ),
            ),
            const Gap(24),
            Text(
              'Your password should have...'.tr(context),
              style: context.textStyleTheme.b14SemiBold.copyWith(color: context.colorTheme.neutral.shade6),
            ),
            const Gap(16),
            BlocBuilder<SignUpRegularFormCubit, SignUpRegularFormState>(
              buildWhen: (previous, current) => previous.password != current.password,
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(7, (index) {
                  if (index.isOdd) return const Gap(4);

                  final values = [
                    (
                      isValid: state.isPasswordAtLeast8Characters,
                      text: 'at least 8 characters',
                    ),
                    (
                      isValid: state.isPasswordAtLeastOneDigit,
                      text: 'at least one digit',
                    ),
                    (
                      isValid: state.isPasswordAtLeastOneUppercase,
                      text: 'at least one uppercase',
                    ),
                    (isValid: state.isPasswordAtLeastOneSpecialCharacter, text: 'at least one special character'),
                  ];

                  return Row(
                    children: [
                      Assets.icon.icSignUpRegularCheck.svg(
                        colorFilter: ColorFilter.mode(
                          values[index ~/ 2].isValid ? const Color(0xFF10C644) : context.colorTheme.neutral.shade6,
                          BlendMode.srcIn,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        values[index ~/ 2].text.tr(context),
                        style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
        Positioned.fill(
          top: null,
          left: 24,
          right: 24,
          bottom: 28,
          child: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) => isKeyboardVisible
                ? const SizedBox.shrink()
                : BlocSelector<SignUpRegularFormCubit, SignUpRegularFormState, bool>(
                    selector: (state) => state.isValid,
                    builder: (context, isValid) => PrimaryButton.filled(
                      onPressed: isValid ? () => widget.pageController.jumpToPage(1) : null,
                      backgroundColor:
                          isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
                      borderRadius: 400,
                      shape: BoxShape.rectangle,
                      text: 'Continue'.tr(context),
                      textColor: context.colorTheme.neutral.shade0,
                      size: const Size.fromHeight(56),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
