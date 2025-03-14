import 'dart:math';

import 'package:bladderly/domain/model/product.dart';
import 'package:equatable/equatable.dart';

class Membership extends Equatable {
  const Membership({
    this.subscription,
    this.remainCount = 0,
  });

  final MembershipSubscription? subscription;

  final int remainCount;

  bool get isValid => subscription?.isValid == true || remainCount > 0;

  Membership use() {
    return Membership(
      subscription: subscription,
      remainCount: max(0, remainCount - 1),
    );
  }

  @override
  List<Object?> get props => [
        subscription,
        remainCount,
      ];
}

class MembershipSubscription extends Equatable {
  const MembershipSubscription({
    required this.product,
    required this.startDate,
    required this.endDate,
    required this.autoRenewal,
  });

  final Product product;

  final DateTime startDate;

  final DateTime endDate;

  final bool autoRenewal;

  bool get isValid {
    final isSameOrAfterThanStartDate = DateTime.now().isAfter(startDate) || DateTime.now().isAtSameMomentAs(startDate);
    final isSameOrBeforeThanEndDate = DateTime.now().isBefore(endDate) || DateTime.now().isAtSameMomentAs(endDate);

    return isSameOrAfterThanStartDate && isSameOrBeforeThanEndDate;
  }

  DateTime? get renewAt => autoRenewal ? endDate : null;

  @override
  List<Object?> get props => [
        product,
        startDate,
        endDate,
        autoRenewal,
      ];
}
