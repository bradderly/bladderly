import 'package:bradderly/app.dart';
import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/data/isar/schema/history_entity.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:isar/isar.dart';
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

  getIt<Isar>().writeTxnSync(getIt<Isar>().historyEntitys.clearSync);

  runApp(const BladderlyApp());
}
