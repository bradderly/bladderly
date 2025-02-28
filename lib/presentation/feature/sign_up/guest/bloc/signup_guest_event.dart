part of 'signup_guest_bloc.dart';

sealed class SignUpGuestEvent extends Equatable {
  const SignUpGuestEvent();

  @override
  List<Object> get props => [];
}

class SignupGuestSubmit extends SignUpGuestEvent {
  const SignupGuestSubmit({
    required this.gender,
    required this.yearOfBirth,
  });

  final Gender gender;
  final int yearOfBirth;

  @override
  List<Object> get props => [
        gender,
        yearOfBirth,
      ];
}
