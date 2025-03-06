// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'symptom_history_form_state.dart';

class SymptomHistoryFormCubit extends Cubit<SymptomHistoryFormState> {
  SymptomHistoryFormCubit() : super(const SymptomHistoryFormState());

  void setOldPassword(String oldPassword) {
    emit(state.copyWith(oldPassword: oldPassword));
  }

  void setNewPassword(String newPassword) {
    emit(state.copyWith(newPassword: newPassword));
  }

  void setConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void toggleOldPasswordVisibility() {
    emit(state.copyWith(obscureOldPassword: !state.obscureOldPassword));
  }

  void toggleNewPasswordVisibility() {
    emit(state.copyWith(obscureNewPassword: !state.obscureNewPassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }
}
