import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgotPasswordVerificationCodeInputField extends StatelessWidget {
  const ForgotPasswordVerificationCodeInputField({
    super.key,
    required this.onChanged,
    this.errorText,
  });

  final ValueChanged<String> onChanged;
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
          child: TextField(
            onChanged: onChanged,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
              isDense: false,
            ),
            style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
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
