import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'plan_form_state.dart';

class PlanFormCubit extends Cubit<PlanFormState> {
  PlanFormCubit() : super(const PlanFormState());
  void setEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void setFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void setLastName(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void setMessage(String message) {
    emit(state.copyWith(message: message));
  }

  void setSubject(String subject) {
    emit(state.copyWith(subject: subject));
  }
}
