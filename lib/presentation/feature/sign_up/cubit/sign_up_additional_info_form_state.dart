part of 'sign_up_additional_info_form_cubit.dart';

class SignUpAdditionalInfoFormState extends Equatable {
  const SignUpAdditionalInfoFormState({
    this.userName = '',
    this.disease = '',
  });

  final String userName;
  final String disease;

  bool get isValid => true;

  SignUpAdditionalInfoFormState copyWith({
    String? userName,
    String? disease,
  }) {
    return SignUpAdditionalInfoFormState(
      userName: userName ?? this.userName,
      disease: disease ?? this.disease,
    );
  }

  @override
  List<Object> get props => [
        userName,
        disease,
      ];
}
