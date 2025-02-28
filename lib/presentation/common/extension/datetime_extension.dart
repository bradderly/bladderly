import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String getCalendarHeader(BuildContext context) {
    return switch (context.locale) {
      AppLocale.en => DateFormat('MMMM, yyyy').format(this),
      AppLocale.ko => DateFormat('yyyy년 MM월').format(this),
    };
  }

  String getMonthTr(BuildContext context) {
    return switch (context.locale) {
      AppLocale.en => DateFormat('MMMM').format(this),
      AppLocale.ko => DateFormat('M월').format(this),
    };
  }

  String getDayMonthDateTr(BuildContext context) {
    return switch (context.locale) {
      AppLocale.en => DateFormat('EEEE, MMM d').format(this),
      AppLocale.ko => '${DateFormat('M월 d일').format(this)} ${getDayOfweek(context)}요일',
    };
  }

  String getDayOfweek(BuildContext context) {
    return context.locale.getDayOfWeek(weekday - 1);
  }
}
