import 'package:bladderly/domain/exception/code_mismatch_exception.dart';
import 'package:bladderly/domain/exception/reset_social_user_password_exception.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:bladderly/presentation/feature/forgot_password/cubit/forgot_password_form_cubit.dart';
import 'package:bladderly/presentation/feature/forgot_password/reset_password/forgot_password_reset_password_view.dart';
import 'package:bladderly/presentation/feature/forgot_password/send_verification_code/forgot_password_send_verification_code_view.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  Future<void> _onChangePasswordFailure(BuildContext context, ForgotPasswordResetPasswordFailure state) async {
    context.pop();

    return switch (state.exception) {
      final CodeMismatchException exception => CommonMessageModal.showFromDominException(
          context,
          onTap: context.pop,
          exception: exception,
        ),
      _ => null,
    };
  }

  Future<void> _onSendVerificationCodeFailure(
    BuildContext context,
    ForgotPasswordSendVerificationCodeFailure state,
  ) async {
    context.pop();

    return switch (state.exception) {
      final ResetSocialUserPasswordException exception => CommonMessageModal.showFromDominException(
          context,
          onTap: context.pop,
          exception: exception,
        ),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) => switch (state) {
        ForgotPasswordSendVerificationCodeInProgress() => ProgressIndicatorModal.show(context),
        ForgotPasswordSendVerificationCodeSuccess() => context.pop(),
        ForgotPasswordSendVerificationCodeFailure() => _onSendVerificationCodeFailure(context, state),
        ForgotPasswordResetPasswordInProgress() => ProgressIndicatorModal.show(context),
        ForgotPasswordResetPasswordSuccess() => const SignInRoute().go(context),
        ForgotPasswordResetPasswordFailure() => _onChangePasswordFailure(context, state),
        _ => null,
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 77,
          leading: IconButton(
            onPressed: context.pop,
            icon: Assets.icon.icCommonArrowBack.svg(),
          ),
          title: Text(
            'Sign In'.tr(context),
            style: context.textStyleTheme.b16SemiBold.copyWith(color: context.colorTheme.neutral.shade10),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            buildWhen: (prev, curr) => prev.showSendVerificationCodeForm != curr.showSendVerificationCodeForm,
            builder: (context, state) => state.showSendVerificationCodeForm
                ? BlocBuilder<ForgotPasswordFormCubit, ForgotPasswordFormState>(
                    buildWhen: (prev, curr) => prev.email != curr.email,
                    builder: (context, state) => ForgotPasswordSendVerificationCodeView(
                      onChangedEamil: context.read<ForgotPasswordFormCubit>().setEmail,
                      onSendVerificationCode: (value) =>
                          context.read<ForgotPasswordBloc>().add(ForgotPasswordSendVerificationCode(email: value)),
                      email: state.email,
                      isValid: state.canSendVerificationCode,
                    ),
                  )
                : BlocBuilder<ForgotPasswordFormCubit, ForgotPasswordFormState>(
                    builder: (context, state) => ForgotPasswordResetPasswordView(
                      onResetPassword: (verificationCode, password, confirmPassword) =>
                          context.read<ForgotPasswordBloc>().add(
                                ForgotPasswordChangePassword(
                                  email: state.email,
                                  verificationCode: verificationCode,
                                  password: password,
                                ),
                              ),
                      onChangedPassword: context.read<ForgotPasswordFormCubit>().setPassword,
                      onChangedConfirmPassword: context.read<ForgotPasswordFormCubit>().setConfirmPassword,
                      onChangedVerificationCode: context.read<ForgotPasswordFormCubit>().setVerificationCode,
                      onChangedObsecurePassword: context.read<ForgotPasswordFormCubit>().setObsecurePassword,
                      onChangedObsecureConfirmPassword:
                          context.read<ForgotPasswordFormCubit>().setObsecureConfirmPassword,
                      password: state.password,
                      obsecurePassword: state.obsecurePassword,
                      confirmPassword: state.confirmPassword,
                      obsecureConfirmPassword: state.obsecureConfirmPassword,
                      verificationCode: state.verificationCode,
                      isValidVerificationCode: state.isVerficationCodeValid,
                      isValidPassword: state.isPasswordValid,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
