// Flutter imports:
// Project imports:
import 'package:bladderly/domain/exception/invalid_user_exception.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/common/widget/common_message_modal.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/common/widget/primary_button.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/profile/change_password/bloc/change_password_bloc.dart';
import 'package:bladderly/presentation/feature/profile/change_password/cubit/change_password_form_cubit.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  // 기존 비밀번호 검증 (8자리 이상만 확인)
  bool _validateOldPassword(String password) {
    return password.length < 8;
  }

  // 비밀번호 검증 함수
  bool _validatePassword(String password) {
    // 길이 검증: 최소 8자
    if (password.length < 8) return true;
    // 숫자 포함 여부 검증
    if (!password.contains(RegExp(r'\d'))) return true;
    // 대문자 포함 여부 검증
    if (!password.contains(RegExp('[A-Z]'))) return true;
    // 특수문자 포함 여부 검증
    if (!password.checkHasLeastOneSpecialCharacter) return true;

    return false;
  }

  void _onChangePassword(BuildContext context) {
    final state = context.read<ChangePasswordFormCubit>().state;
    final userModel = context.read<UserBloc>().state.userModelOrThrowException;

    final emailText = userModel is RegularUserModel ? userModel.email : '';
    context
        .read<ChangePasswordBloc>()
        .add(ChangePassword(email: emailText, oldPw: state.oldPassword, newPw: state.newPassword));
  }

  Future<void> _onChangeFailure(BuildContext context, ChangePasswordFailure state) async {
    context.pop();

    return switch (state.exception) {
      final InvalidUserException exception => CommonMessageModal.showFromDominException(
          context,
          onTap: context.pop,
          exception: exception,
        ),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) => switch (state) {
        ChangePasswordInProgress() => ProgressIndicatorModal.show(context),
        ChangePasswordSuccess() => context
          ..pop()
          ..pop(),
        ChangePasswordFailure() => _onChangeFailure(context, state),
        _ => null,
      },
      child: Scaffold(
        appBar: ModalAppBar(title: 'Change Password'.tr(context)),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: ModalScrollController.of(context),
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BlocSelector<ChangePasswordFormCubit, ChangePasswordFormState, bool>(
                        selector: (state) => state.obscureOldPassword,
                        builder: (_, obscureOldPassword) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Old Password'.tr(context),
                              style:
                                  context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                            ),
                            const Gap(16),
                            TextField(
                              onChanged: (value) => context.read<ChangePasswordFormCubit>().setOldPassword(value),
                              obscureText: obscureOldPassword,
                              obscuringCharacter: '*', // 별표로 대체
                              style:
                                  context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                              decoration: InputDecoration(
                                hintText: 'Type old password'.tr(context),
                                hintStyle:
                                    context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade6),
                                filled: true,
                                fillColor: context.colorTheme.neutral.shade2,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureOldPassword ? Icons.visibility : Icons.visibility_off,
                                    color: context.colorTheme.neutral.shade6,
                                  ),
                                  onPressed: context.read<ChangePasswordFormCubit>().toggleOldPasswordVisibility,
                                ),
                              ),
                            ),
                            errorText(
                              'Your password must be at least 8 characters long.'.tr(context),
                              context,
                              _validateOldPassword(context.watch<ChangePasswordFormCubit>().state.oldPassword) &&
                                  context.read<ChangePasswordFormCubit>().state.isValid,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BlocSelector<ChangePasswordFormCubit, ChangePasswordFormState, bool>(
                        selector: (state) => state.obscureNewPassword,
                        builder: (_, obscureNewPassword) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Password'.tr(context),
                              style:
                                  context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                            ),
                            const Gap(16),
                            TextField(
                              onChanged: (value) => context.read<ChangePasswordFormCubit>().setNewPassword(value),
                              obscureText: obscureNewPassword,
                              obscuringCharacter: '*', // 별표로 대체
                              style:
                                  context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                              decoration: InputDecoration(
                                hintText: 'Type new password'.tr(context),
                                hintStyle:
                                    context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade6),
                                filled: true,
                                fillColor: context.colorTheme.neutral.shade2,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                                    color: context.colorTheme.neutral.shade6,
                                  ),
                                  onPressed: context.read<ChangePasswordFormCubit>().toggleNewPasswordVisibility,
                                ),
                              ),
                            ),
                            errorText(
                              'Password must be at least 8 characters long and include a digit, uppercase letter, and special character.'
                                  .tr(context),
                              context,
                              _validatePassword(context.watch<ChangePasswordFormCubit>().state.newPassword) &&
                                  context.read<ChangePasswordFormCubit>().state.isValid,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BlocSelector<ChangePasswordFormCubit, ChangePasswordFormState, bool>(
                        selector: (state) => state.obscureConfirmPassword,
                        builder: (_, obscureConfirmPassword) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm New Password'.tr(context),
                              style:
                                  context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                            ),
                            const Gap(16),
                            TextField(
                              onChanged: (value) => context.read<ChangePasswordFormCubit>().setConfirmPassword(value),
                              obscureText: obscureConfirmPassword,
                              obscuringCharacter: '*', // 별표로 대체
                              style:
                                  context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
                              decoration: InputDecoration(
                                hintText: 'Re-type new password'.tr(context),
                                hintStyle:
                                    context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade6),
                                filled: true,
                                fillColor: context.colorTheme.neutral.shade2,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                                    color: context.colorTheme.neutral.shade6,
                                  ),
                                  onPressed: context.read<ChangePasswordFormCubit>().toggleConfirmPasswordVisibility,
                                ),
                              ),
                            ),
                            errorText(
                              'Passwords do not match'.tr(context),
                              context,
                              context.watch<ChangePasswordFormCubit>().state.newPassword !=
                                      context.watch<ChangePasswordFormCubit>().state.confirmPassword &&
                                  context.read<ChangePasswordFormCubit>().state.isValid,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocSelector<ChangePasswordFormCubit, ChangePasswordFormState, bool>(
                selector: (state) => state.isValid,
                builder: (context, isValid) => PrimaryButton.filled(
                  onPressed: (isValid &&
                          context.watch<ChangePasswordFormCubit>().state.newPassword ==
                              context.watch<ChangePasswordFormCubit>().state.confirmPassword &&
                          !_validatePassword(context.watch<ChangePasswordFormCubit>().state.newPassword) &&
                          !_validateOldPassword(context.watch<ChangePasswordFormCubit>().state.oldPassword))
                      ? () => _onChangePassword(context)
                      : null, // Save 버튼 클릭 시 검증

                  backgroundColor: (isValid &&
                          context.watch<ChangePasswordFormCubit>().state.newPassword ==
                              context.watch<ChangePasswordFormCubit>().state.confirmPassword &&
                          !_validatePassword(context.watch<ChangePasswordFormCubit>().state.newPassword) &&
                          !_validateOldPassword(context.watch<ChangePasswordFormCubit>().state.oldPassword))
                      ? context.colorTheme.vermilion.primary.shade50
                      : context.colorTheme.neutral.shade6,
                  borderRadius: 8,
                  shape: BoxShape.rectangle,
                  text: 'Save'.tr(context),
                  textColor: context.colorTheme.neutral.shade0,
                  size: const Size(256, 48),
                ),
              ),
              const Gap(28),
            ],
          ),
        ),
      ),
    );
  }
}

Widget errorText(String text, BuildContext context, bool isError) {
  if (!isError) {
    return const SizedBox.shrink();
  }

  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Text(
      text,
      style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.warning),
    ),
  );
}
