part of 'promo_code_bloc.dart';

sealed class PromoCodeState extends Equatable {
  const PromoCodeState();

  @override
  List<Object> get props => [];
}

final class PromoCodeInitial extends PromoCodeState {
  const PromoCodeInitial();
}

final class PromoCodeProgress extends PromoCodeState {
  const PromoCodeProgress();
}

final class PromoCodeSuccess extends PromoCodeState {
  const PromoCodeSuccess();
}

final class PromoCodeFailure extends PromoCodeState {
  const PromoCodeFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
