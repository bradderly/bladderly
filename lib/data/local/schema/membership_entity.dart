import 'package:objectbox/objectbox.dart';

@Entity()
class MembershipEntity {
  @Id()
  int id = 0;

  @Unique(onConflict: ConflictStrategy.replace)
  late int userId;

  String? productId;

  DateTime? startDate;

  DateTime? endDate;

  bool? autoRenewal;

  late int remainCount;

  late int exportRemainCount;

  @Transient()
  MembershipSubscriptionEntity? get subscription {
    if (productId == null || startDate == null || endDate == null || autoRenewal == null) {
      return null;
    }

    return MembershipSubscriptionEntity(
      productId: productId!,
      startDate: startDate!,
      endDate: endDate!,
      autoRenewal: autoRenewal!,
    );
  }
}

class MembershipSubscriptionEntity {
  const MembershipSubscriptionEntity({
    required this.productId,
    required this.startDate,
    required this.endDate,
    required this.autoRenewal,
  });

  final String productId;

  final DateTime startDate;

  final DateTime endDate;

  final bool autoRenewal;
}
