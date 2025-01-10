import 'package:bradderly/app.dart';
import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // add this

  await Translation().initialize();

  await configureDependencies();

  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());

  runApp(const BladderlyApp());
}
