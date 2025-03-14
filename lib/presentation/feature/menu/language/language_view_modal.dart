// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LanguageViewModal extends StatefulWidget {
  const LanguageViewModal({
    super.key,
    required this.appLocale,
  });

  final AppLocale appLocale;

  @override
  State<LanguageViewModal> createState() => _LanguageViewModalState();
}

class _LanguageViewModalState extends State<LanguageViewModal> {
  late AppLocale appLocale = widget.appLocale;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ModalTitle(title: 'Language'.tr(context, appLocale: appLocale)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                controller: controller,
                children: List.generate(AppLocale.values.length, (index) {
                  final locale = AppLocale.values[index];
                  return _buildLanguageOption(
                    context,
                    isSelected: appLocale == locale,
                    appLocale: locale,
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => context.pop(appLocale),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.green, // Save 버튼 스타일
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Save'.tr(context, appLocale: appLocale),
                  style: context.textStyleTheme.b16SemiBold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required bool isSelected,
    required AppLocale appLocale,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: () => setState(() => this.appLocale = appLocale),
          visualDensity: const VisualDensity(vertical: -4),
          leading: isSelected
              ? Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50)
              : const SizedBox(width: 24),
          title: Text(
            appLocale.text,
            style: context.textStyleTheme.b14Medium.copyWith(
              color: context.colorTheme.neutral.shade9,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Divider(color: context.colorTheme.neutral.shade4),
        ),
      ],
    );
  }
}
