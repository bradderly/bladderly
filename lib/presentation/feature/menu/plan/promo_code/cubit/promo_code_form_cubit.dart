// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'promo_code_form_state.dart';

class PromoCodeFormCubit extends Cubit<PromoCodeFormState> {
  PromoCodeFormCubit() : super(const PromoCodeFormState());
  void setCode(String code) {
    emit(state.copyWith(code: code));
  }
}
