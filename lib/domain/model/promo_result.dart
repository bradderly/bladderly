import 'package:equatable/equatable.dart';

abstract class PromoResult extends Equatable {
  factory PromoResult({
    required String result,
    required String popup,
  }) {
    if (result.contains('offer')) {
      return OfferPromoResult(code: result.replaceAll('offer', '').trim(), popup: popup);
    } else if (result == 'not exist') {
      return const NonePromoResult();
    } else {
      return MembershipPromoResult(result: result, popup: popup);
    }
  }

  const PromoResult._({
    required this.popup,
  });

  final String popup;

  @override
  List<Object> get props => [
        popup,
      ];
}

class OfferPromoResult extends PromoResult {
  const OfferPromoResult({
    required super.popup,
    required this.code,
  }) : super._();

  final String code;
}

class MembershipPromoResult extends PromoResult {
  const MembershipPromoResult({
    required super.popup,
    required String result,
  })  : _result = result,
        super._();

  final String _result;

  bool get isValid => _result == 'exist';
}

class NonePromoResult extends PromoResult {
  const NonePromoResult()
      : title = 'Invalid Code',
        super._(
          popup:
              'That promo code didn’t work. Try entering it again, and if you’re still having trouble, email us at hello@bladderly.com for assistance.',
        );

  final String title;

  @override
  List<Object> get props => [
        title,
        popup,
      ];
}
