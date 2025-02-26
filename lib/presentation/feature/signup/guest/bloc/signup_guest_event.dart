part of 'signup_guest_bloc.dart';

sealed class SignupGuestEvent extends Equatable {
  const SignupGuestEvent();

  @override
  List<Object> get props => [];
}

class SignupGuestSubmit extends SignupGuestEvent {
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
