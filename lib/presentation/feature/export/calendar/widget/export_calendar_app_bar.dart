// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

class ExportCalendarAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExportCalendarAppBar({
    super.key,
    required this.onTapToday,
  });

  final VoidCallback onTapToday;
  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  right: null,
                  left: 16,
                  child: Center(
                    child: GestureDetector(
                      onTap: onTapToday,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                        decoration: BoxDecoration(
                          border: Border.all(color: context.colorTheme.vermilion.primary.shade40),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Today'.tr(context),
                          style: context.textStyleTheme.b16SemiBold.copyWith(
                            color: context.colorTheme.vermilion.primary.shade40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Select Date'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: context.colorTheme.neutral.shade10,
                    ),
                  ),
                ),
                Positioned.fill(
                  right: 16,
                  left: null,
                  child: GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: Assets.icon.icExportClose.svg(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: context.colorTheme.neutral.shade5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
