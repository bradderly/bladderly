import 'package:bladderly/app.dart';
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait(
    [
      FlutterLocalization.instance.ensureInitialized(),
      Translation().initialize(),
      configureDependencies(),
      HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory())
          .then((value) => HydratedBloc.storage = value),
    ],
  );

  runApp(const BladderlyApp());
}
