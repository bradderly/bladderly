part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentInitializeHandler extends PaymentEvent {
  const PaymentInitializeHandler({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [userId];
}

class PaymentPurchasePlan extends PaymentEvent {
  const PaymentPurchasePlan({
    required this.planId,
  });

  final String planId;

  @override
  List<Object> get props => [
        planId,
      ];
}
