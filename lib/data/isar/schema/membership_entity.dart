import 'package:isar/isar.dart';

part 'membership_entity.g.dart';

@collection
class MembershipEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late int userId;

  late String productId;

  late DateTime startDate;

  late DateTime endDate;

  late bool autoRenewal;
}
