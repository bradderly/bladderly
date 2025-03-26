import 'package:objectbox/objectbox.dart';

@Entity()
class RateTriggerEntity {
  @Id()
  int id = 0;

  // Total event count
  int count = 0;
  int attemptNumber = 0;
}
