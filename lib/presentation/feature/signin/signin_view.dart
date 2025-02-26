import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/signin/cubit/signin_form_cubit.dart';
import 'package:bradderly/presentation/feature/signin/widget/signin_field_widget.dart';
import 'package:bradderly/presentation/feature/signin/widget/signin_social_signin_button_widget.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          children: [
            Text(
              'Log in'.tr(context),
              style: context.textStyleTheme.b24Bold.copyWith(color: context.colorTheme.neutral.shade10),
            ),
            const Gap(24),
            Text(
              'It’s free, secure and easy.\nWe will save your data safely.'.tr(context),
              style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
            ),
            const Gap(44),
            SigninFieldWidget(
              text: 'Email Address'.tr(context),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.neutral.shade2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
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
            SigninFieldWidget(
              text: 'Password'.tr(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: context.colorTheme.neutral.shade2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BlocSelector<SigninFormCubit, SigninFormState, bool>(
                      selector: (state) => state.obscurePassword,
                      builder: (_, obscurePassword) => TextField(
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
                          isDense: false,
                          suffixIcon: GestureDetector(
                            onTap: context.read<SigninFormCubit>().togglePasswordVisibility,
                            child: Icon(
                              obscurePassword ? Icons.visibility : Icons.visibility_off,
                              size: 24,
                              color: context.colorTheme.neutral.shade6,
                            ),
                          ),
                        ),
                        style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: obscurePassword,
                      ),
                    ),
                  ),
                  const Gap(8),
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: context.colorTheme.vermilion.primary.shade50),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Forgot Password?'.tr(context),
                        style: context.textStyleTheme.b14SemiBold.copyWith(
                          color: context.colorTheme.vermilion.primary.shade50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(32),
            SigninSocialSigninButtonWidget(
              onTap: (signinMethod) {
                // context.read<SigninFormCubit>().signinWithSocial(signinMethod);
              },
            ),
          ],
        ),
      ),
    );
  }
}
