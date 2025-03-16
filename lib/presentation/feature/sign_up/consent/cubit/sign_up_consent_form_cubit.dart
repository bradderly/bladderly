import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_consent_form_state.dart';

class SignUpConsentFormCubit extends Cubit<SignUpConsentFormState> {
  SignUpConsentFormCubit() : super(const SignUpConsentFormState());

  void setAgreedToTermAndPrivacyPolicy(bool value) {
    emit(state.copyWith(agreedToTermAndPrivacyPolicy: value));
  }

  void setAgreedToPersonalDataCollectionAndProcessing(bool value) {
    emit(state.copyWith(agreedToPersonalDataCollectionAndProcessing: value));
  }

  void setAgreedToDataTransferAndStorageOutside(bool value) {
    emit(state.copyWith(agreedToDataTransferAndStorageOutside: value));
  }
}
