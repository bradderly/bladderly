import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:flutter/foundation.dart';

extension StringExtension on String {
  String get tr {
    return Translation().translate(key: this, locale: AppLocale.of(PlatformDispatcher.instance.locale.languageCode));
  }
}
