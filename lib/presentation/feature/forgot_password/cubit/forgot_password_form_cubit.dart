import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_form_state.dart';

class ForgotPasswordFormCubit extends Cubit<ForgotPasswordFormState> {
  ForgotPasswordFormCubit() : super(const ForgotPasswordFormState());

  void setEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void setVerificationCode(String verificationCode) {
    emit(state.copyWith(verificationCode: verificationCode));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password));
  }

  void setConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void setObsecurePassword(bool obsecurePassword) {
    emit(state.copyWith(obsecurePassword: !state.obsecurePassword));
  }

  void setObsecureConfirmPassword(bool obsecureConfirmPassword) {
    emit(state.copyWith(obsecureConfirmPassword: obsecureConfirmPassword));
  }
}
