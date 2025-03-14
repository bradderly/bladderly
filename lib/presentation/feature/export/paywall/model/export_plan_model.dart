import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ExportPlanModel extends Equatable {
  const ExportPlanModel({
    required this.product,
    required this.name,
    required double price,
    required double originPrice,
    required String symbol,
  })  : _price = price,
        _originPrice = originPrice,
        _symbol = symbol;

  ExportPlanModel.fromDomain(Plan plan)
      : product = plan.product,
        name = plan.name,
        _price = plan.price,
        _originPrice = plan.originPrice,
        _symbol = plan.symbol;

  final Product product;
  final String name;
  final double _price;
  final double _originPrice;
  final String _symbol;

  String get price => _formatPrice(_price);

  String _formatPrice(double price) {
    final hasDecimal = '$price'.contains('.');

    final decimalPlaces = hasDecimal ? '$price'.split('.').last.length : 0;

    return NumberFormat.currency(symbol: _symbol, decimalDigits: decimalPlaces).format(price);
  }

  @override
  List<Object?> get props => [
        product,
        name,
        _price,
        _originPrice,
        _symbol,
      ];
}
