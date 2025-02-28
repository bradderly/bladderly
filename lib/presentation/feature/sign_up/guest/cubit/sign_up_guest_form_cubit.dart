import 'package:bladderly/domain/model/sex.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_guest_form_state.dart';

class SignUpGuestFormCubit extends Cubit<SignUpGuestFormState> {
  SignUpGuestFormCubit() : super(const SignUpGuestFormState());

  void setSex(Gender sex) {
    return emit(state.copyWith(sex: sex));
  }

  void setYearOfBirth(String yearOfBirth) {
    return emit(state.copyWith(yearOfBirth: yearOfBirth));
  }
}
