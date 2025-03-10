import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmailAddressInputField extends StatelessWidget {
  const EmailAddressInputField({
    super.key,
    required this.onChanged,
    required this.email,
    this.errorText,
  });

  final ValueChanged<String> onChanged;
  final String email;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colorTheme.neutral.shade2,
            borderRadius: BorderRadius.circular(12),
            border: errorText == null
                ? null
                : Border.all(
                    color: context.colorTheme.warning,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
          ),
          child: TextFormField(
            onChanged: onChanged,
            initialValue: email,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
              isDense: false,
              hintText: 'username@email.com',
              hintStyle: TextStyle(color: context.colorTheme.neutral.shade6),
            ),
            style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        if (errorText case final String errorText) ...[
          const Gap(8),
          Text(
            errorText,
            style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.warning),
          ),
        ],
      ],
    );
  }
}
