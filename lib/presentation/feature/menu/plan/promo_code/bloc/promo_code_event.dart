part of 'promo_code_bloc.dart';

sealed class PromoCodeEvent extends Equatable {
  const PromoCodeEvent();

  @override
  List<Object> get props => [];
}

class PromoCode extends PromoCodeEvent {
  const PromoCode({
    required this.userId,
    required this.code,
  });

  final String userId;
  final String code;

  @override
  List<Object> get props => [
        userId,
        code,
      ];
}
