// Package imports:
// Project imports:
import 'package:bladderly/core/di/di.config.dart';
import 'package:bladderly/core/rate_checker/rating_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
  getIt<RatingHelper>().init();
}
