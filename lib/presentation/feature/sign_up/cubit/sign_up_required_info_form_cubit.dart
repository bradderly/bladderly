import 'package:bladderly/domain/model/sex.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_required_info_form_state.dart';

class SignUpRequiredInfoFormCubit extends Cubit<SignUpRequiredInfoFormState> {
  SignUpRequiredInfoFormCubit() : super(const SignUpRequiredInfoFormState());

  void setGender(Gender gender) {
    return emit(state.copyWith(gender: gender));
  }

  void setYearOfBirth(String yearOfBirth) {
    return emit(state.copyWith(yearOfBirth: yearOfBirth));
  }
}
