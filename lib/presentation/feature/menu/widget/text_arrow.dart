import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class TextArrow extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const TextArrow({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
        decoration: BoxDecoration(
          color: context.colorTheme.neutral.shade0,
          boxShadow: [],
          border: Border(
            bottom:
                BorderSide(color: context.colorTheme.neutral.shade5, width: 2),
          ), // Added border only at the bottom
        ),
        child: Row(
          children: [
            Expanded(
              // 🔥 이걸 추가하면 무한 너비 문제 해결
              child: Text(
                title,
                style: context.textStyleTheme.b16Medium.copyWith(
                    color: context.colorTheme.neutral.shade10),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: context.colorTheme.neutral.shade6), // 우측 화살표
          ],
        ),
      ),
    );
  }
}
