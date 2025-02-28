import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({super.key});

  @override
  State<ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  bool _passwordError1 = false;
  final bool _passwordError2 = false;
  final bool _passwordError3 = false;

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
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    ModalTitle(context, 'Change Password'.tr(context)),
                    const SizedBox(height: 41),
                    PasswordField(
                      labelText: 'Old Password'.tr(context),
                      hintText: 'Type old password'.tr(context),
                    ),
                    errorText('Your password is too short.'.tr(context), context, _passwordError1),
                    const SizedBox(height: 20),
                    PasswordField(
                      labelText: 'New Password'.tr(context),
                      hintText: 'Type new password'.tr(context),
                    ),
                    errorText('Password must be at least 8 characters long'.tr(context), context, _passwordError2),
                    const SizedBox(height: 20),
                    PasswordField(
                      labelText: 'Confirm New Password'.tr(context),
                      hintText: 'Re-type new password'.tr(context),
                    ),
                    errorText('Password must be at least 8 characters long'.tr(context), context, _passwordError3),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _passwordError1 = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 109, vertical: 12),
                  decoration: BoxDecoration(
                    color: context.colorTheme.neutral.shade6,
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
  });
  final String labelText;
  final String hintText;

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
