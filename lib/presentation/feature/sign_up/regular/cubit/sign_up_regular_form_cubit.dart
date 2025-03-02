// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_regular_form_state.dart';

class SignUpRegularFormCubit extends Cubit<SignUpRegularFormState> {
  SignUpRegularFormCubit() : super(const SignUpRegularFormState());

  void setEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password));
  }

  void toggleObsecurePassword() {
    emit(state.copyWith(obsecurePassword: !state.obsecurePassword));
  }
}
