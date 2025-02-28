import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/sign_in/bloc/signin_bloc.dart';
import 'package:bladderly/presentation/feature/sign_in/cubit/sign_in_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_in/widget/sign_in_field_widget.dart';
import 'package:bladderly/presentation/feature/sign_in/widget/sign_in_social_signin_button_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  void _signIn(BuildContext context) {
    final state = context.read<SignInFormCubit>().state;

    context.read<SignInBloc>().add(SignInEmail(email: state.email, password: state.password));
  }

  void _onSigninSocialSuccess(BuildContext context, SignInSocialSuccess state) {
    final extra = SignUpGuestRouteExtra(
      email: state.email,
      signUpMethod: state.signUpMethod.name,
    );

    SignUpGuestRoute($extra: extra).go(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) => switch (state) {
        SignInInProgress() => ProgressIndicatorModal.show(context),
        SignInEmailFailure() => context.pop(),
        SignInEmailSuccess() => const MainRoute().go(context),
        SignInSocialSuccess() => _onSigninSocialSuccess(context, state),
        SignInSocialFailure() => context.pop(),
        _ => null,
      },
      child: Scaffold(
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
              SignInFieldWidget(
                text: 'Email Address'.tr(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorTheme.neutral.shade2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: (value) => context.read<SignInFormCubit>().setEmail(value),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: context.colorTheme.neutral.shade2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: BlocSelector<SignInFormCubit, SignInFormState, bool>(
                        selector: (state) => state.obscurePassword,
                        builder: (_, obscurePassword) => TextField(
                          onChanged: (value) => context.read<SignInFormCubit>().setPassword(value),
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
                            isDense: false,
                            suffixIcon: GestureDetector(
                              onTap: context.read<SignInFormCubit>().togglePasswordVisibility,
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
              BlocSelector<SignInFormCubit, SignInFormState, bool>(
                selector: (state) => state.isValid,
                builder: (context, isValid) => PrimaryButton.filled(
                  onPressed: isValid
                      ? () => _signIn(context)
                      : () {
                          context.read<SignInFormCubit>().setEmail('ext-test@sh.com');
                          context.read<SignInFormCubit>().setPassword('Qwer12!@');
                        },
                  backgroundColor:
                      isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
                  borderRadius: 400,
                  shape: BoxShape.rectangle,
                  text: 'Next',
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size.fromHeight(56),
                ),
              ),
              const Gap(32),
              SignInSocialSigninButtonWidget(
                onTap: (signUpMethod) => context.read<SignInBloc>().add(SignInSocial(signUpMethod: signUpMethod)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
