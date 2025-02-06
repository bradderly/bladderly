
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class ReasonOption extends StatelessWidget {
  final String reason;
  final bool isSelected;
  final VoidCallback onSelect;

  const ReasonOption({
    required this.reason,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reason,
          style: context.textStyleTheme.b16Medium
              .copyWith(color: context.colorTheme.neutral.shade6)),
      leading: Radio<String>(
          value: reason,
          groupValue: isSelected ? reason : null,
          onChanged: (value) => onSelect(),
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return context
                  .colorTheme.vermilion.primary.shade50; // 선택된 상태일 때 색상
            }
            return context.colorTheme.neutral.shade6; // 기본 색상
          })),
      onTap: onSelect,
      contentPadding:
          EdgeInsets.symmetric(vertical: 2, horizontal: 0), // 기본 패딩 줄이기
      dense: true, // ListTile의 높이를 더 줄이기
    );
  }
}
