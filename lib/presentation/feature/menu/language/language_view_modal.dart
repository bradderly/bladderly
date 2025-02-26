import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/widget/modal_title.dart';
import 'package:flutter/material.dart';

class LanguageViewModal extends StatefulWidget {
  const LanguageViewModal({super.key});

  @override
  _LanguageViewModalState createState() => _LanguageViewModalState();
}

class _LanguageViewModalState extends State<LanguageViewModal> {
  String _selectedLanguage = 'English (United States)';
  String _basicLanguage = 'English (United States)';

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.95,
      builder: (_, controller) {
        return Container(
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
              ModalTitle(context, 'Language'.tr(context)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    _buildLanguageOption('Korean'),
                    _buildLanguageOption('English (United States)'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: (_basicLanguage != _selectedLanguage)
                        ? context.colorTheme.vermilion.primary.shade50
                        : context.colorTheme.neutral.shade6,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Save'.tr(context),
                    style: context.textStyleTheme.b16SemiBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(vertical: -4), // 높이를 줄이는 값
          leading: _selectedLanguage == language
              ? Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50)
              : const SizedBox(width: 24),
          title: Text(
            language,
            style: context.textStyleTheme.b14Medium.copyWith(
              color: context.colorTheme.neutral.shade9,
            ),
          ),
          onTap: () {
            setState(() {
              _selectedLanguage = language;
            });
          },
        ),
        Padding(padding: const EdgeInsets.only(left: 50), child: Divider(color: context.colorTheme.neutral.shade4)),
      ],
    );
  }
}
