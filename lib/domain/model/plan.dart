import 'package:bladderly/domain/model/product.dart';
import 'package:equatable/equatable.dart';

class Plan extends Equatable {
  const Plan({
    required this.product,
    required this.name,
    required this.price,
    required this.originPrice,
    required this.symbol,
  });

  final Product product;
  final String name;
  final double price;
  final double originPrice;
  final String symbol;

  @override
  List<Object> get props => [
        name,
        price,
        originPrice,
      ];
}
