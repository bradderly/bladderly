import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_additional_info_form_state.dart';

class SignUpAdditionalInfoFormCubit extends Cubit<SignUpAdditionalInfoFormState> {
  SignUpAdditionalInfoFormCubit() : super(const SignUpAdditionalInfoFormState());

  void setUserName(String userName) {
    emit(state.copyWith(userName: userName));
  }

  void setDisease(String disease) {
    emit(state.copyWith(disease: disease));
  }
}
