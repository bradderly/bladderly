// Package imports:
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_method_form_state.dart';

class SignUpMethodFormCubit extends Cubit<SignUpMethodFormState> {
  SignUpMethodFormCubit() : super(const SignUpMethodFormState());

  void setEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password));
  }

  void toggleObsecurePassword(bool obsecurePassword) {
    emit(state.copyWith(obsecurePassword: obsecurePassword));
  }

  void reset() {
    emit(const SignUpMethodFormState());
  }
}
