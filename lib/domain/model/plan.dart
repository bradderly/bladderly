import 'package:equatable/equatable.dart';

class Plan extends Equatable {
  const Plan({
    required this.id,
    required this.name,
    required this.price,
    required this.originPrice,
    required this.symbol,
  });

  final String id;
  final String name;
  final double price;
  final double originPrice;
  final String symbol;

  @override
  List<Object> get props => [
        id,
        name,
        price,
        originPrice,
      ];
}
