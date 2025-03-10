// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/feature/menu/language/language_view_modal.dart';
import 'package:flutter/material.dart';

class LanguageViewBuilder extends StatelessWidget {
  const LanguageViewBuilder({
    super.key,
    required this.appLocale,
  });

  final AppLocale appLocale;

  @override
  Widget build(BuildContext context) {
    return LanguageViewModal(appLocale: appLocale);
  }
}
