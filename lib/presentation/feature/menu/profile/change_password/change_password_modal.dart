import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/model/user_model.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/bloc/change_password_bloc.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/cubit/change_password_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChangePasswordModal extends StatelessWidget {
  const ChangePasswordModal({super.key});

  // 기존 비밀번호 검증 (8자리 이상만 확인)
  bool _validateOldPassword(String password) {
    return password.length < 8;
  }

  // 비밀번호 검증 함수s
  bool _validatePassword(String password) {
    // 길이 검증: 최소 8자
    if (password.length < 8) return true;
    // 숫자 포함 여부 검증
    if (!password.contains(RegExp(r'\d'))) return true;
    // 대문자 포함 여부 검증
    if (!password.contains(RegExp('[A-Z]'))) return true;
    // 특수문자 포함 여부 검증
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return true;
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

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) => switch (state) {
            ChangePasswordInitial() => ProgressIndicatorModal.show(context),
            ChangePasswordSuccess() => {
                Navigator.of(context).pop(),
              },
            ChangePasswordFailure() => {},
            _ => null,
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 41),
            child: Column(
              children: [
                ModalTitle(context, 'Change Password'.tr(context)),
                Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
                      const SizedBox(height: 41),
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
                              const SizedBox(height: 16),
                              TextField(
                                onChanged: (value) => context.read<ChangePasswordFormCubit>().setOldPassword(value),
                                obscureText: obscureOldPassword,
                                obscuringCharacter: '*', // 별표로 대체
                                style: context.textStyleTheme.b16Medium
                                    .copyWith(color: context.colorTheme.neutral.shade10),
                                decoration: InputDecoration(
                                  hintText: 'Type old password'.tr(context),
                                  hintStyle: context.textStyleTheme.b16Medium
                                      .copyWith(color: context.colorTheme.neutral.shade6),
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
                      const SizedBox(height: 20),
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
                              const SizedBox(height: 16),
                              TextField(
                                onChanged: (value) => context.read<ChangePasswordFormCubit>().setNewPassword(value),
                                obscureText: obscureNewPassword,
                                obscuringCharacter: '*', // 별표로 대체
                                style: context.textStyleTheme.b16Medium
                                    .copyWith(color: context.colorTheme.neutral.shade10),
                                decoration: InputDecoration(
                                  hintText: 'Type new password'.tr(context),
                                  hintStyle: context.textStyleTheme.b16Medium
                                      .copyWith(color: context.colorTheme.neutral.shade6),
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
                      const SizedBox(height: 20),
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
                              const SizedBox(height: 16),
                              TextField(
                                onChanged: (value) => context.read<ChangePasswordFormCubit>().setConfirmPassword(value),
                                obscureText: obscureConfirmPassword,
                                obscuringCharacter: '*', // 별표로 대체
                                style: context.textStyleTheme.b16Medium
                                    .copyWith(color: context.colorTheme.neutral.shade10),
                                decoration: InputDecoration(
                                  hintText: 'Re-type new password'.tr(context),
                                  hintStyle: context.textStyleTheme.b16Medium
                                      .copyWith(color: context.colorTheme.neutral.shade6),
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
                  builder: (context, isValid) => GestureDetector(
                    behavior: HitTestBehavior.opaque,

                    onTap: (isValid &&
                            context.watch<ChangePasswordFormCubit>().state.newPassword ==
                                context.watch<ChangePasswordFormCubit>().state.confirmPassword &&
                            !_validatePassword(context.watch<ChangePasswordFormCubit>().state.newPassword) &&
                            !_validateOldPassword(context.watch<ChangePasswordFormCubit>().state.oldPassword))
                        ? () => _onChangePassword(context)
                        : null, // Save 버튼 클릭 시 검증
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                      decoration: BoxDecoration(
                        color: (isValid &&
                                context.watch<ChangePasswordFormCubit>().state.newPassword ==
                                    context.watch<ChangePasswordFormCubit>().state.confirmPassword &&
                                !_validatePassword(context.watch<ChangePasswordFormCubit>().state.newPassword) &&
                                !_validateOldPassword(context.watch<ChangePasswordFormCubit>().state.oldPassword))
                            ? context.colorTheme.vermilion.primary.shade50
                            : context.colorTheme.neutral.shade6,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Save'.tr(context),
                        style: context.textStyleTheme.b16SemiBold.copyWith(
                          color: context.colorTheme.neutral.shade0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget errorText(String text, BuildContext context, bool isError) {
  if (!isError) {
    return const SizedBox();
  }
  return Padding(
    padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
    child: Text(
      text,
      style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.warning),
    ),
  );
}
