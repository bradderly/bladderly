import 'package:isar/isar.dart';

@collection
class MembershipEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  @Name('user_id')
  late String userId;

  late DateTime startAt;

  late DateTime endAt;

  DateTime? renewAt;
}
