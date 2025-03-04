// Flutter imports:

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:csv/csv.dart';

// Project imports:
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

enum AppLocale {
  en,
  ko,
  ;

  factory AppLocale.of(String name) {
    return AppLocale.values.firstWhereOrNull((e) => e.name == name) ?? AppLocale.en;
  }

  String getDayOfWeek(int index) {
    return switch (this) {
      AppLocale.en => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
      AppLocale.ko => ['월', '화', '수', '목', '금', '토', '일'][index],
    };
  }

  String getMonth(int index) {
    return switch (this) {
      AppLocale.en => ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][index],
      AppLocale.ko => ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'][index],
    };
  }

  bool get isEn => this == AppLocale.en;
}

class Translation {
  Translation._();

  // ignore: sort_unnamed_constructors_first
  factory Translation() => _instance;

  static final _instance = Translation._();

  final _translations = <AppLocale, Map<String, String>>{};

  Future<void> initialize() async {
    if (_translations.isNotEmpty) return;

    final fileContent = await rootBundle.loadString(Assets.i18n.stringsI18n);

    final rows = const CsvToListConverter().convert(fileContent);

    final header = rows.removeAt(0);

    final keyIndex = header.indexOf('key');

    final localeIndexMap = AppLocale.values.fold<Map<AppLocale, int>>(
      {},
      (map, locale) => map..[locale] = header.indexOf(locale.name),
    );

    for (final row in rows) {
      final key = row.elementAtOrNull(keyIndex)?.toString().replaceAll(r'\n', '\n');

      if (key == null) continue;

      for (final localIndexMapEntry in localeIndexMap.entries) {
        final locale = localIndexMapEntry.key;
        final index = localIndexMapEntry.value;

        if (_translations[locale] == null) {
          _translations[locale] = <String, String>{};
        }

        _translations[locale]?[key] = '${row.elementAtOrNull(index)}'.replaceAll(r'\n', '\n');
      }
    }
  }

  String translate({required String key, required AppLocale locale}) {
    final map = switch (_translations[locale]) {
      final Map<String, String> map => map,
      null => _translations[AppLocale.en],
    };

    return map?[key] ?? key;
  }
}
