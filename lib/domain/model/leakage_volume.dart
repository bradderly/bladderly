import 'package:collection/collection.dart';

enum LeakageVolume {
  Small,
  Medium,
  Large,
  ;

  static LeakageVolume? findOneOrNullByName(String name) {
    return values.firstWhereOrNull((element) => element.name == name);
  }
}
