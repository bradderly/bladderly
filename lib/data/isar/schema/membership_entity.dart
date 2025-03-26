import 'package:isar/isar.dart';

part 'membership_entity.g.dart';

@collection
class MembershipEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late int userId;

  MembershipSubscriptionEntity? subscription;

  late int remainCount;

  late int exportRemainCount;
}

@Embedded()
class MembershipSubscriptionEntity {
  late String productId;

  late DateTime startDate;

  late DateTime endDate;

  late bool autoRenewal;
}
