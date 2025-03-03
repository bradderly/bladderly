// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/bloc/change_password_bloc.dart';
import 'package:bladderly/presentation/feature/menu/profile/change_password/cubit/change_password_form_cubit.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';

class ChangePasswordModal extends StatelessWidget {
  ChangePasswordModal({super.key});

  bool _passwordError1 = false;

  bool _passwordError2 = false;

  bool _passwordMismatch = false;

// getIt<SignInUsecase>()
  bool _isAllFieldsFilled = false;

  // 기존 비밀번호 검증 (8자리 이상만 확인)
  bool _validateOldPassword(String password) {
    return password.length >= 8;
  }

  // 비밀번호 검증 함수
  bool _validatePassword(String password) {
    // 길이 검증: 최소 8자
    if (password.length < 8) return false;
    // 숫자 포함 여부 검증
    if (!password.contains(RegExp(r'\d'))) return false;
    // 대문자 포함 여부 검증
    if (!password.contains(RegExp('[A-Z]'))) return false;
    // 특수문자 포함 여부 검증
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  void _onChangePassword(BuildContext context) {
    print('111');
    final state = context.read<ChangePasswordFormCubit>().state;

    print('Valid data, proceed with API call');
    context
        .read<ChangePasswordBloc>()
        .add(ChangePassword(email: 'ext-test@sh.com', oldPw: state.oldPassword, newPw: state.newPassword));

    print('result');
  }

  /*
  Future<void> _onSavePressed(String oldPassword,String newPassword,String confirmPassword  ) async {
    setState(() {
      _passwordError1 = !_validateOldPassword(oldPassword); // 기존 비밀번호는 8자리 이상만 체크
      _passwordError2 = !_validatePassword(newPassword); // 새로운 비밀번호는 더 복잡한 조건 체크
      _passwordMismatch = newPassword != confirmPassword;
    });

    if (!_passwordError1 && !_passwordError2 && !_passwordMismatch && _isAllFieldsFilled) {
      // API 통신을 여기서 호출
      print('Valid data, proceed with API call');

      context
          .read<ChangePasswordBloc>()
          .add(ChangePassword(email: 'ext-test@sh.com', oldPw: oldPassword, newPw: newPassword));

      print('result');
    }
  }
  */
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Old Password'.tr(context),
                            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                          ),
                          const SizedBox(height: 16),
                          BlocSelector<ChangePasswordFormCubit, ChangePasswordFormState, bool>(
                            selector: (state) => state.obscureOldPassword,
                            builder: (_, obscureOldPassword) => TextField(
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
                          ),
                        ],
                      ),
                    ),
                    errorText(
                      'Your password must be at least 8 characters long.'.tr(context),
                      context,
                      _passwordError1,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Password'.tr(context),
                            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                          ),
                          const SizedBox(height: 16),
                          BlocSelector<ChangePasswordFormCubit, ChangePasswordFormState, bool>(
                            selector: (state) => state.obscureNewPassword,
                            builder: (_, obscureNewPassword) => TextField(
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
                          ),
                        ],
                      ),
                    ),
                    errorText(
                      'Password must be at least 8 characters long and include a digit, uppercase letter, and special character.'
                          .tr(context),
                      context,
                      _passwordError2,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Confirm New Password'.tr(context),
                            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
                          ),
                          const SizedBox(height: 16),
                          BlocSelector<ChangePasswordFormCubit, ChangePasswordFormState, bool>(
                            selector: (state) => state.obscureConfirmPassword,
                            builder: (_, obscureConfirmPassword) => TextField(
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
                          ),
                        ],
                      ),
                    ),
                    errorText('Passwords do not match'.tr(context), context, _passwordMismatch),
                  ],
                ),
              ),
              BlocSelector<ChangePasswordFormCubit, ChangePasswordFormState, bool>(
                selector: (state) => state.isValid,
                builder: (context, isValid) => GestureDetector(
                  behavior: HitTestBehavior.opaque,

                  onTap: isValid ? () => _onChangePassword(context) : null, // Save 버튼 클릭 시 검증
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                    decoration: BoxDecoration(
                      color: isValid ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6,
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
