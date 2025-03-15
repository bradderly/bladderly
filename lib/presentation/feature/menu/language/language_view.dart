// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({
    super.key,
    required this.appLocale,
  });

  final AppLocale appLocale;

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  late AppLocale appLocale = widget.appLocale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(
        title: 'Language'.tr(context, appLocale: appLocale),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                controller: ModalScrollController.of(context),
                physics: const ClampingScrollPhysics(),
                itemCount: AppLocale.values.length,
                itemBuilder: (context, index) => _buildLanguageOption(
                  context,
                  isSelected: appLocale == AppLocale.values[index],
                  appLocale: AppLocale.values[index],
                ),
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
            const SizedBox(height: 28),
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
          leading: isSelected
              ? Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50)
              : const SizedBox(width: 24),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              appLocale.text,
              style: context.textStyleTheme.b16Regular.copyWith(
                color: context.colorTheme.neutral.shade10,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Divider(
            color: context.colorTheme.neutral.shade4,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
