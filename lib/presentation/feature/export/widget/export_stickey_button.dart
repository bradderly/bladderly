import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExportStickeyButton extends StatelessWidget {
  const ExportStickeyButton({
    super.key,
    required this.text,
    this.onTap,
    this.header,
  });

  final VoidCallback? onTap;
  final Widget? header;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 44, bottom: 33),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.colorTheme.neutral.shade0.withValues(alpha: 0),
            context.colorTheme.neutral.shade0.withValues(alpha: 0.78),
            context.colorTheme.neutral.shade0,
          ],
          stops: const [0, 0.11, 0.22],
        ),
      ),
      child: Column(
        children: [
          if (header case final Widget header) ...[
            header,
            const Gap(16),
          ],
          GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              width: 256,
              padding: const EdgeInsets.symmetric(vertical: 14.5),
              decoration: BoxDecoration(
                color: onTap == null ? context.colorTheme.neutral.shade6 : context.colorTheme.vermilion.primary.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                text,
                style: context.textStyleTheme.b16SemiBold.copyWith(
                  color: context.colorTheme.neutral.shade0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
