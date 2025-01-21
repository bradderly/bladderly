import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String get calendarHeader {
    return switch (AppLocale.current) {
      AppLocale.en => DateFormat('MMMM, yyyy').format(this),
      AppLocale.ko => DateFormat('yyyy년 MM월').format(this),
    };
  }

  String get dayOfweek {
    return switch (AppLocale.current) {
      AppLocale.en => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      AppLocale.ko => ['월', '화', '수', '목', '금', '토', '일'],
    }[weekday - 1];
  }
}
