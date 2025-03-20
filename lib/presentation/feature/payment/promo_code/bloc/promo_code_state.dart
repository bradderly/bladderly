part of 'promo_code_bloc.dart';

sealed class PromoCodeState extends Equatable {
  const PromoCodeState();

  @override
  List<Object> get props => [];
}

final class PromoCodeInitial extends PromoCodeState {
  const PromoCodeInitial();
}

final class PromoCodeCheckInProgress extends PromoCodeState {
  const PromoCodeCheckInProgress();
}

final class PromoCodeCheckSuccess extends PromoCodeState {
  const PromoCodeCheckSuccess({
    required this.promoResult,
  });

  final PromoResult promoResult;

  @override
  List<Object> get props => [
        ...super.props,
        promoResult,
      ];
}

final class PromoCodeCheckFailure extends PromoCodeState {
  const PromoCodeCheckFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
