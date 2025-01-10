import 'package:bradderly/domain/model/urination.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

@module
abstract class IsarModule {
  @preResolve
  Future<Isar> get isar async {
    final applicationDocumentsDirectory = await getApplicationDocumentsDirectory();

    if (Isar.getInstance() case final Isar isar) return isar;

    return Isar.open(
      [
        UrinationSchema,
      ],
      directory: applicationDocumentsDirectory.path,
    );
  }
}
