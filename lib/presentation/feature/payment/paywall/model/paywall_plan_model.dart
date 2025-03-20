import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class PaywallPlanModel extends Equatable {
  const PaywallPlanModel._({
    required this.product,
    required this.name,
    required String priceStr,
    required double price,
    required double originPrice,
    required String symbol,
  })  : _priceStr = priceStr,
        _price = price,
        _originPrice = originPrice,
        _symbol = symbol;

  factory PaywallPlanModel.fromDomain(Plan plan) {
    return PaywallPlanModel._(
      product: plan.product,
      name: plan.name,
      priceStr: plan.priceStr,
      price: plan.price,
      originPrice: plan.originPrice,
      symbol: plan.symbol,
    );
  }

  final Product product;
  final String name;
  final String _priceStr;
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
    // 기존 소숫점 자리수
    final hasDecimal = _priceStr.contains('.');
    final originDecimalPlaces = hasDecimal ? (_priceStr.split('.').lastOrNull?.length ?? 0) : 0;

    final decimalPlaces = switch (originDecimalPlaces) {
      // 소수점 2자리 초과면 2자리로 고정
      final int length when length > 2 => 2,
      final int length => length,
    };

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
