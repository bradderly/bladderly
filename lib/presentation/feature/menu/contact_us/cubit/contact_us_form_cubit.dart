// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_us_form_state.dart';

class ContactUsFormCubit extends Cubit<ContactUsFormState> {
  ContactUsFormCubit({
    required String initialEmail,
    required String initialFirstName,
    required String initialLastName,
  }) : super(ContactUsFormState(email: initialEmail, firstName: initialFirstName, lastName: initialLastName));

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
