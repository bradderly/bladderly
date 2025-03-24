// Flutter imports:

// Project imports:
import 'package:bladderly/app.dart';
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/core/notification/notification_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notifly_flutter/notifly_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait(
    [
      configureDependencies(),
      HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory())
          .then((value) => HydratedBloc.storage = value),
      FlutterLocalization.instance.ensureInitialized(),
      Firebase.initializeApp(),
      NotiflyPlugin.initialize(
        projectId: kDebugMode ? '50b0b535baac5bf1bd3877640f6bdacb' : 'dd000087d726596b9324ef93f982a899',
        username: 'bladderly',
        password: 'bb2c9e132ce148fabeaa3a2abe77889a@A',
      ),
    ],
  );

  runApp(BladderlyApp(notificationService: getIt<NotificationService>()));
}
