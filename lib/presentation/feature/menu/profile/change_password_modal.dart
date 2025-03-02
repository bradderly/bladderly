import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/bloc/menu_bloc.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({super.key});

  @override
  State<ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  bool _passwordError1 = false;
  bool _passwordError2 = false;
  bool _passwordMismatch = false;
// getIt<SignInUsecase>()

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // 데이터가 모두 채워졌는지 체크하는 변수
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

  // 모든 필드가 채워졌는지 체크하는 함수
  void _checkIfAllFieldsFilled() {
    setState(() {
      _isAllFieldsFilled = _oldPasswordController.text.isNotEmpty &&
          _newPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  Future<void> _onSavePressed() async {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _passwordError1 = !_validateOldPassword(oldPassword); // 기존 비밀번호는 8자리 이상만 체크
      _passwordError2 = !_validatePassword(newPassword); // 새로운 비밀번호는 더 복잡한 조건 체크
      _passwordMismatch = newPassword != confirmPassword;
    });

    if (!_passwordError1 && !_passwordError2 && !_passwordMismatch && _isAllFieldsFilled) {
      // API 통신을 여기서 호출
      print('Valid data, proceed with API call');

      context.read<MenuBloc>().add(ChangePassword(email: 'ext-test@sh.com', oldPw: oldPassword, newPw: newPassword));

      print('result');
    }
  }

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
                    PasswordField(
                      labelText: 'Old Password'.tr(context),
                      hintText: 'Type old password'.tr(context),
                      controller: _oldPasswordController, // 텍스트 컨트롤러 연결
                      onChanged: (_) => _checkIfAllFieldsFilled(), // 필드 변경 시 체크
                    ),
                    errorText(
                      'Your password must be at least 8 characters long.'.tr(context),
                      context,
                      _passwordError1,
                    ),
                    const SizedBox(height: 20),
                    PasswordField(
                      labelText: 'New Password'.tr(context),
                      hintText: 'Type new password'.tr(context),
                      controller: _newPasswordController, // 텍스트 컨트롤러 연결
                      onChanged: (_) => _checkIfAllFieldsFilled(), // 필드 변경 시 체크
                    ),
                    errorText(
                      'Password must be at least 8 characters long and include a digit, uppercase letter, and special character.'
                          .tr(context),
                      context,
                      _passwordError2,
                    ),
                    const SizedBox(height: 20),
                    PasswordField(
                      labelText: 'Confirm New Password'.tr(context),
                      hintText: 'Re-type new password'.tr(context),
                      controller: _confirmPasswordController, // 텍스트 컨트롤러 연결
                      onChanged: (_) => _checkIfAllFieldsFilled(), // 필드 변경 시 체크
                    ),
                    errorText('Passwords do not match'.tr(context), context, _passwordMismatch),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _onSavePressed, // Save 버튼 클릭 시 검증
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                  decoration: BoxDecoration(
                    color: _isAllFieldsFilled
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
            ],
          ),
        );
      },
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onChanged, // 필드 변경 시 호출되는 콜백 추가
  });
  final String labelText;
  final String hintText;
  final TextEditingController controller; // TextEditingController 추가
  final ValueChanged<String> onChanged; // 텍스트 변경 시 호출되는 콜백

  @override
  // ignore: library_private_types_in_public_api
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.neutral.shade6),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: widget.controller, // 텍스트 필드에 컨트롤러 연결
            obscureText: _obscureText,
            obscuringCharacter: '*', // 별표로 대체
            style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade6),
              filled: true,
              fillColor: context.colorTheme.neutral.shade2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: context.colorTheme.neutral.shade6,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            onChanged: widget.onChanged, // 텍스트 변경 시 호출되는 콜백 설정
          ),
        ],
      ),
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
