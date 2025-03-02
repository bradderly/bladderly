// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:hydrated_bloc/hydrated_bloc.dart';

// Project imports:
import 'package:bladderly/presentation/common/locale/app_locale.dart';

class AppLocaleCubit extends HydratedCubit<AppLocale> {
  AppLocaleCubit() : super(AppLocale.of(PlatformDispatcher.instance.locale.languageCode));

  void changeLocale(AppLocale locale) {
    emit(locale);
  }

  @override
  AppLocale? fromJson(Map<String, dynamic> json) {
    if (json['locale'] case final String locale) {
      return AppLocale.of(locale);
    }

    return null;
  }

  @override
  Map<String, dynamic>? toJson(AppLocale state) {
    return {
      'locale': state.name,
    };
  }
}
