import 'package:equatable/equatable.dart';

class Membership extends Equatable {
  const Membership({
    required this.productId,
    required this.startDate,
    required this.endDate,
    required this.autoRenewal,
  });

  final String productId;

  final DateTime startDate;

  final DateTime endDate;

  final bool autoRenewal;

  @override
  List<Object?> get props => [
        productId,
        startDate,
        endDate,
        autoRenewal,
      ];
}
