import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';

class ExportTermAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExportTermAppBar({
    super.key,
  });

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
                Center(
                  child: Text(
                    'Data Report'.tr(context),
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
