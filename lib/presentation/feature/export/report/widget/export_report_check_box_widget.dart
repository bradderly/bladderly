import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExportReportCheckBoxWidget extends StatelessWidget {
  const ExportReportCheckBoxWidget({
    super.key,
    required this.onTap,
    required this.isChecked,
    required this.child,
  });

  final VoidCallback onTap;
  final bool isChecked;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: isChecked ? context.colorTheme.vermilion.primary.shade30 : context.colorTheme.neutral.shade5,
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecked ? context.colorTheme.vermilion.primary.shade50 : Colors.transparent,
                ),
              ),
            ),
            const Gap(13),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
