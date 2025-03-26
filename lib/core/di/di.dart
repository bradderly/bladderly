// Package imports:
// Project imports:
import 'package:bladderly/core/di/di.config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init(
    // android, ios 분기를 태우기 위함
    environment: defaultTargetPlatform.name,
  );
}
