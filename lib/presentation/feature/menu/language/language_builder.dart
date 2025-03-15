// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/feature/menu/language/language_view.dart';
import 'package:flutter/material.dart';

class LanguageBuilder extends StatelessWidget {
  const LanguageBuilder({
    super.key,
    required this.appLocale,
  });

  final AppLocale appLocale;

  @override
  Widget build(BuildContext context) {
    return LanguageView(appLocale: appLocale);
  }
}
