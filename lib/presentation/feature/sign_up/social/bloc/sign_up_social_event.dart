part of 'sign_up_social_bloc.dart';

sealed class SignUpSocialEvent extends Equatable {
  const SignUpSocialEvent();

  @override
  List<Object> get props => [];
}

class SignUpSocialSubmit extends SignUpSocialEvent {
  const SignUpSocialSubmit({
    required this.email,
    required this.signUpMethod,
    required this.gender,
    required this.yearOfBirth,
    required this.userName,
    required this.disease,
  });

  final String email;
  final SignUpMethod signUpMethod;
  final Gender gender;
  final int yearOfBirth;
  final String userName;
  final String disease;

  @override
  List<Object> get props => [
        email,
        signUpMethod,
        gender,
        yearOfBirth,
        userName,
        disease,
      ];
}
