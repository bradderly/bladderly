// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/feature/menu/widget/modal_title.dart';

class LanguageViewModal extends StatelessWidget {
  const LanguageViewModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLocaleCubit, AppLocale>(
      builder: (context, state) {
        final selectedLanguageCode = state.name;
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
                        _buildLanguageOption(context, 'ko', 'Korean', selectedLanguageCode),
                        _buildLanguageOption(context, 'en', 'English (United States)', selectedLanguageCode),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
      },
    );
  }

  Widget _buildLanguageOption(BuildContext context, String code, String language, String selectedLanguageCode) {
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(vertical: -4),
          leading: selectedLanguageCode == code
              ? Icon(Icons.check, color: context.colorTheme.vermilion.primary.shade50)
              : const SizedBox(width: 24),
          title: Text(
            language,
            style: context.textStyleTheme.b14Medium.copyWith(
              color: context.colorTheme.neutral.shade9,
            ),
          ),
          onTap: () {
            context.read<AppLocaleCubit>().changeLocale(AppLocale.of(code));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Divider(color: context.colorTheme.neutral.shade4),
        ),
      ],
    );
  }
}
