import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class ParimaryTextField extends StatelessWidget {
  const ParimaryTextField({
    super.key,
    this.label,
    this.hintText,
    this.errorText,
    this.obscureText = false,
  });

  final String? label;
  final String? hintText;
  final String? errorText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label case final String label)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(label),
          ),
        TextField(
          style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade10),
          autocorrect: false,
          enableSuggestions: false,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.colorTheme.neutral.shade10, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.colorTheme.neutral.shade10, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.colorTheme.warning, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.colorTheme.warning, width: 2),
            ),
            suffix: Icon(Icons.error, color: context.colorTheme.warning),
            error: switch (errorText) {
              final String errorText => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    errorText,
                    style: context.textStyleTheme.b14Medium.copyWith(color: context.colorTheme.warning),
                  ),
                ),
              _ => null,
            },
            hintText: hintText,
            filled: true,
            hoverColor: context.colorTheme.neutral.shade2,
            fillColor: context.colorTheme.neutral.shade2,
            focusColor: context.colorTheme.neutral.shade2,
          ),
        ),
      ],
    );
  }
}
