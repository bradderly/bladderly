import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class ExportReportTextField extends StatelessWidget {
  const ExportReportTextField({
    super.key,
    required this.onChanged,
    required this.onSubmitted,
    required this.focusNode,
    required this.hintText,
  });

  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final FocusNode focusNode;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      scrollPadding: const EdgeInsets.only(bottom: 120),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        fillColor: context.colorTheme.neutral.shade2,
        filled: true,
        isDense: true,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        hintStyle: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade7),
      ),
      style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade7),
    );
  }
}
