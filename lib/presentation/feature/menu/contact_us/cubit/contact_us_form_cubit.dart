// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_us_form_state.dart';

class ContactUsFormCubit extends Cubit<ContactUsFormState> {
  ContactUsFormCubit() : super(const ContactUsFormState());

  void setId(String id) {
    emit(state.copyWith(id: id));
  }

  void setEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setMessage(String message) {
    emit(state.copyWith(message: message));
  }

  void initializeForm({required String id, required String name, required String email}) {
    emit(state.copyWith(id: id, name: name, email: email));
  }
}
