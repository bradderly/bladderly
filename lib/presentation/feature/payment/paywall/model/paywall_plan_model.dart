import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class PaywallPlanModel extends Equatable {
  const PaywallPlanModel._({
    required this.product,
    required this.name,
    required double price,
    required double originPrice,
    required String symbol,
  })  : _price = price,
        _originPrice = originPrice,
        _symbol = symbol;

  factory PaywallPlanModel.fromDomain(Plan plan) {
    return PaywallPlanModel._(
      product: plan.product,
      name: plan.name,
      price: plan.price,
      originPrice: plan.originPrice,
      symbol: plan.symbol,
    );
  }

  final Product product;
  final String name;
  final double _price;
  final double _originPrice;
  final String _symbol;

  bool get isDiscounted => _originPrice > _price;

  String get price => _formatPrice(_price);

  String get originPrice => _formatPrice(_originPrice);

  String get monthlyPrice =>
      product == Product.annualSubscription ? _formatPrice(_price / 12) : throw UnimplementedError();

  bool get isAnnualSubscription => product == Product.annualSubscription;

  bool get isThreeDaysPass => product == Product.threeDaysPass;

  String _formatPrice(double price) {
    final hasDecimal = '$price'.contains('.');

    final decimalPlaces = hasDecimal ? '$price'.split('.').last.length : 0;

    return NumberFormat.currency(symbol: _symbol, decimalDigits: decimalPlaces).format(price);
  }

  @override
  List<Object> get props => [
        product,
        name,
        price,
        originPrice,
      ];
}
