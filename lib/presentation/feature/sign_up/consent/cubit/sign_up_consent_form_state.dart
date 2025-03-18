part of 'sign_up_consent_form_cubit.dart';

class SignUpConsentFormState extends Equatable {
  const SignUpConsentFormState({
    this.agreedToTermAndPrivacyPolicy = false,
    this.agreedToPersonalDataCollectionAndProcessing = false,
    this.agreedToDataTransferAndStorageOutside = false,
  });

  final bool agreedToTermAndPrivacyPolicy;

  final bool agreedToPersonalDataCollectionAndProcessing;

  final bool agreedToDataTransferAndStorageOutside;

  SignUpConsentFormState copyWith({
    bool? agreedToTermAndPrivacyPolicy,
    bool? agreedToPersonalDataCollectionAndProcessing,
    bool? agreedToDataTransferAndStorageOutside,
  }) {
    return SignUpConsentFormState(
      agreedToTermAndPrivacyPolicy: agreedToTermAndPrivacyPolicy ?? this.agreedToTermAndPrivacyPolicy,
      agreedToPersonalDataCollectionAndProcessing:
          agreedToPersonalDataCollectionAndProcessing ?? this.agreedToPersonalDataCollectionAndProcessing,
      agreedToDataTransferAndStorageOutside:
          agreedToDataTransferAndStorageOutside ?? this.agreedToDataTransferAndStorageOutside,
    );
  }

  bool get isValid =>
      agreedToTermAndPrivacyPolicy &&
      agreedToPersonalDataCollectionAndProcessing &&
      agreedToDataTransferAndStorageOutside;

  @override
  List<Object> get props => [
        agreedToTermAndPrivacyPolicy,
        agreedToPersonalDataCollectionAndProcessing,
        agreedToDataTransferAndStorageOutside,
      ];
}
