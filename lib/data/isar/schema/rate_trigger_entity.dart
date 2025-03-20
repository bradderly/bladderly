import 'package:isar/isar.dart';

part 'rate_trigger_entity.g.dart';

@collection
class RateTriggerEntity {
  Id id = Isar.autoIncrement;

  // Total event count
  int count = 0;
  int attemptNumber = 0;
}
