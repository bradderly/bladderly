part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

final class PaymentInitializeHandlerInProgress extends PaymentState {
  const PaymentInitializeHandlerInProgress();
}

final class PaymentInitializeHandlerSuccess extends PaymentState {
  const PaymentInitializeHandlerSuccess();
}

final class PaymentInitializeHandlerFailure extends PaymentState {
  const PaymentInitializeHandlerFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        exception,
      ];
}

final class PaymentPurchaseReadyInProgress extends PaymentState {
  const PaymentPurchaseReadyInProgress();
}

final class PaymentPurchaseReadySuccess extends PaymentState {
  const PaymentPurchaseReadySuccess({
    required this.product,
  });

  final Product product;

  @override
  List<Object> get props => [
        product,
      ];
}

final class PaymentPurchaseReadyFailure extends PaymentState {
  const PaymentPurchaseReadyFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        exception,
      ];
}

final class PaymentPurchaseInProgress extends PaymentState {
  const PaymentPurchaseInProgress();
}

final class PaymentPurchaseSuccess extends PaymentState {
  const PaymentPurchaseSuccess();

  @override
  List<Object> get props => [];
}

final class PaymentPurchaseRestored extends PaymentState {
  const PaymentPurchaseRestored();

  @override
  List<Object> get props => [];
}

/// 결제 진행 중 취소를 뜻함 환불 X
final class PaymentPurchaseCanceled extends PaymentState {
  const PaymentPurchaseCanceled();

  @override
  List<Object> get props => [];
}

final class PaymentPurchaseFailure extends PaymentState {
  const PaymentPurchaseFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
      ];
}
