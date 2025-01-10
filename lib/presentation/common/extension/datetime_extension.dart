import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String get calendarHeader {
    return switch (AppLocale.current) {
      AppLocale.en => DateFormat('MMMM, yyyy').format(this),
      AppLocale.ko => DateFormat('yyyy년 MM월').format(this),
    };
  }
}
