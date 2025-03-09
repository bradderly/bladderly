import 'package:bladderly/domain/model/plan.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class PaywallPlanModel extends Equatable {
  const PaywallPlanModel._({
    required this.id,
    required this.name,
    required double price,
    required double originPrice,
    required String symbol,
  })  : _price = price,
        _originPrice = originPrice,
        _symbol = symbol;

  factory PaywallPlanModel.fromDomain(Plan plan) {
    return PaywallPlanModel._(
      id: plan.id,
      name: plan.name,
      price: plan.price,
      originPrice: plan.originPrice,
      symbol: plan.symbol,
    );
  }

  final String id;
  final String name;
  final double _price;
  final double _originPrice;
  final String _symbol;

  bool get isDiscounted => _originPrice > _price;

  String get price => _formatPrice(_price);

  String get originPrice => _formatPrice(_originPrice);

  String get monthlyPrice => isAnnual ? _formatPrice(_price / 12) : throw UnimplementedError();

  /// TODO(eden): 추후 서버에서 데이터 내려오는식으로 변경되면 수정 필요
  bool get isAnnual => id.contains('annual');

  String _formatPrice(double price) {
    final hasDecimal = '$price'.contains('.');

    final decimalPlaces = hasDecimal ? '$price'.split('.').last.length : 0;

    return NumberFormat.currency(symbol: _symbol, decimalDigits: decimalPlaces).format(price);
  }

  @override
  List<Object> get props => [
        id,
        name,
        price,
        originPrice,
      ];
}
