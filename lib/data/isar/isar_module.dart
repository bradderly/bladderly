// Package imports:

// Package imports:
import 'package:bladderly/data/isar/schema/score_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:bladderly/data/isar/isar_client.dart';
import 'package:bladderly/data/isar/schema/apple_credential_entity.dart';
import 'package:bladderly/data/isar/schema/history_entity.dart';
import 'package:bladderly/data/isar/schema/user_entity.dart';

@module
abstract class IsarModule {
  Future<Isar> get _isar async {
    final applicationDocumentsDirectory = await getApplicationDocumentsDirectory();

    if (Isar.getInstance() case final Isar isar) return isar;

    return Isar.open(
      [
        HistoryEntitySchema,
        UserEntitySchema,
        AppleCredentialEntitySchema,
        ScoreEntitySchema,
      ],
      directory: applicationDocumentsDirectory.path,
    );
  }

  @lazySingleton
  @preResolve
  Future<IsarClient> isarClient() async {
    return IsarClient(await _isar);
  }
}
