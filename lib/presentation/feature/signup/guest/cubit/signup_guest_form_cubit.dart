import 'package:bradderly/domain/model/sex.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_guest_form_state.dart';

class SignupGuestFormCubit extends Cubit<SignupGuestFormState> {
  SignupGuestFormCubit() : super(const SignupGuestFormState());

  void setSex(Sex sex) {
    return emit(state.copyWith(sex: sex));
  }

  void setYearOfBirth(String yearOfBirth) {
    return emit(state.copyWith(yearOfBirth: yearOfBirth));
  }
}
