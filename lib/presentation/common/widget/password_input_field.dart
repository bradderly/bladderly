import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    super.key,
    required this.onToggleObsecureText,
    required this.onChanged,
    required this.obsecureText,
    this.errorText,
  });

  final ValueChanged<bool> onToggleObsecureText;
  final ValueChanged<String> onChanged;
  final bool obsecureText;
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
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
              isDense: false,
              suffixIcon: GestureDetector(
                onTap: () => onToggleObsecureText(!obsecureText),
                child: Icon(
                  obsecureText ? Icons.visibility : Icons.visibility_off,
                  size: 24,
                  color: context.colorTheme.neutral.shade6,
                ),
              ),
            ),
            style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
            obscureText: obsecureText,
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
