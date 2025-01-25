import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppLocaleCubit extends HydratedCubit<AppLocale> {
  AppLocaleCubit() : super(AppLocale.current);

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
