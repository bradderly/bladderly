part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentInitializeHandler extends PaymentEvent {
  const PaymentInitializeHandler({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [
        userId,
      ];
}

class PaymentPurchasePlan extends PaymentEvent {
  const PaymentPurchasePlan({
    required this.userId,
    required this.planId,
    this.offerToken,
  });

  final String userId;
  final String planId;
  final String? offerToken;

  @override
  List<Object?> get props => [
        userId,
        planId,
        offerToken,
      ];
}

class PaymentRestorePlan extends PaymentEvent {
  const PaymentRestorePlan();

  @override
  List<Object> get props => [];
}
