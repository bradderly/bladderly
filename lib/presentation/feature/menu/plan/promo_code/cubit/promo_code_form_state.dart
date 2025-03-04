part of 'promo_code_form_cubit.dart';

class PromoCodeFormState extends Equatable {
  const PromoCodeFormState({
    this.code = '',
  });

  final String code;

  PromoCodeFormState copyWith({
    String? code,
  }) {
    return PromoCodeFormState(
      code: code ?? this.code,
    );
  }

  bool get isValid => code.isNotEmpty;

  @override
  List<Object> get props => [
        code,
      ];
}
