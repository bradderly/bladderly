// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';

class ReasonOption extends StatelessWidget {
  const ReasonOption({
    super.key,
    required this.reason,
    required this.isSelected,
    required this.onSelect,
  });
  final String reason;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        reason,
        style: context.textStyleTheme.b16Medium.copyWith(color: context.colorTheme.neutral.shade6),
      ),
      leading: Radio<String>(
        value: reason,
        groupValue: isSelected ? reason : null,
        onChanged: (value) => onSelect(),
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return context.colorTheme.vermilion.primary.shade50; // 선택된 상태일 때 색상
          }
          return context.colorTheme.neutral.shade6; // 기본 색상
        }),
      ),
      onTap: onSelect,
      contentPadding: const EdgeInsets.symmetric(vertical: 2), // 기본 패딩 줄이기
      dense: true, // ListTile의 높이를 더 줄이기
    );
  }
}
