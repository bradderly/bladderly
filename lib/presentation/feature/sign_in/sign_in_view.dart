// Flutter imports:

import 'package:bladderly/domain/exception/invalid_user_exception.dart';
import 'package:bladderly/domain/exception/not_found_apple_credential_exception.dart';
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
// Flutter imports:
import 'package:bladderly/domain/exception/password_attempts_exceeded_exception.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_error_modal.dart';
import 'package:bladderly/presentation/common/widget/password_input_field.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/common/widget/social_signin_button_widget.dart';
import 'package:bladderly/presentation/feature/sign_in/bloc/signin_bloc.dart';
import 'package:bladderly/presentation/feature/sign_in/cubit/sign_in_form_cubit.dart';
import 'package:bladderly/presentation/feature/sign_in/widget/sign_in_field_widget.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  void _signIn(BuildContext context) {
    final state = context.read<SignInFormCubit>().state;

    context.read<SignInBloc>().add(SignInEmail(email: state.email, password: state.password));
  }

  Future<void> _onEmailFailure(BuildContext context, SignInEmailFailure state) {
    context.pop();

    return switch (state.exception) {
      NotFoundUserException() => CommonErrorModal.showFromDominException<void>(
          context,
          onTap: context.pop,
          exception: const InvalidUserException(),
        ),
      final InvalidUserException exception => CommonErrorModal.showFromDominException<void>(
          context,
          onTap: context.pop,
          exception: exception,
        ),
      _ => showDialog<AlertDialog>(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              state.exception.toString(),
            ),
            actions: [
              TextButton(
                onPressed: context.pop,
                child: Text('Okay'.tr(context)),
              ),
            ],
          ),
        ),
    };
  }

  void _onSocialFailure(BuildContext context, SignInSocialFailure state) {
    context.pop();

    // if (state.email case final String email) {
    return switch (state.exception) {
      NotFoundAppleCredentialException() => showDialog<AlertDialog>(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text(
              'Please stop using Apple ID and Try again. Go to Settings > Apple ID > Password & Security > Apps using Apple ID > proudP > Stop using Apple ID',
            ),
            actions: [
              TextButton(
                onPressed: context.pop,
                child: Text('Okay'.tr(context)),
              ),
            ],
          ),
        ),
      NotFoundUserException() => SignUpSocialRoute(
          $extra: SignUpSocialRouteExtra(email: state.email ?? '', signUpMethod: state.signUpMethod.name),
        ).go(context),
      final PasswordAttemptsExceededException exception => CommonErrorModal.showFromDominException<void>(
          context,
          onTap: context.pop,
          exception: exception,
        ),
      _ => showDialog<AlertDialog>(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              state.exception.toString(),
            ),
            actions: [
              TextButton(
                onPressed: context.pop,
                child: Text('Okay'.tr(context)),
              ),
            ],
          ),
        ),
    };
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignInBloc, SignInState>(
          listener: (context, state) => switch (state) {
            SignInInProgress() => ProgressIndicatorModal.show(context),
            SignInEmailFailure() => _onEmailFailure(context, state),
            SignInSocialFailure() => _onSocialFailure(context, state),
            _ => null,
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) => switch (state) {
            UserLoadSuccess() => const MainRoute().go(context),
            _ => null,
          },
        ),
      ],
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
                'Just 3 seconds is enough. Log in and store your data for free and securely!'.tr(context),
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
                        builder: (_, obscurePassword) => PasswordInputField(
                          obsecureText: obscurePassword,
                          onToggleObsecureText: (value) => context.read<SignInFormCubit>().togglePasswordVisibility(),
                          onChanged: (value) => context.read<SignInFormCubit>().setPassword(value),
                        ),
                      ),
                    ),
                    const Gap(8),
                    GestureDetector(
                      onTap: () => const ForgotPasswordRoute().go(context),
                      behavior: HitTestBehavior.translucent,
                      child: Stack(
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
                    ),
                  ],
                ),
              ),
              const Gap(32),
              BlocSelector<SignInFormCubit, SignInFormState, bool>(
                selector: (state) => state.isValid,
                builder: (context, isValid) => PrimaryButton.filled(
                  onPressed: isValid ? () => _signIn(context) : null,
                  backgroundColor:
                      isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
                  borderRadius: 400,
                  shape: BoxShape.rectangle,
                  text: 'Next'.tr(context),
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size.fromHeight(56),
                ),
              ),
              const Gap(32),
              SocialSigninButtonWidget(
                onTap: (signUpMethod) => context.read<SignInBloc>().add(SignInSocial(signUpMethod: signUpMethod)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
