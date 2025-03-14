import 'package:bladderly/domain/model/product.dart';
import 'package:equatable/equatable.dart';

class Membership extends Equatable {
  const Membership({
    required this.product,
    required this.startDate,
    required this.endDate,
    required this.autoRenewal,
  });

  final Product product;

  final DateTime startDate;

  final DateTime endDate;

  final bool autoRenewal;

  bool get isValid => DateTime.now().isBefore(endDate);

  @override
  List<Object?> get props => [
        product,
        startDate,
        endDate,
        autoRenewal,
      ];
}
