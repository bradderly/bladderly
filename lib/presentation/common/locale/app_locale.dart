import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:collection/collection.dart';
import 'package:csv2json/csv2json.dart';
import 'package:flutter/services.dart';

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

    final jsons = csv2json(fileContent);

    for (final json in jsons) {
      final key = json.remove('key');

      if (key == null) continue;

      for (final entry in json.entries) {
        (_translations[AppLocale.of(entry.key)] ??= <String, String>{})
            .addAll({key: entry.value.replaceAll(r'\n', '\n')});
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
