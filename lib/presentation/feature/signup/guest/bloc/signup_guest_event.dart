part of 'signup_guest_bloc.dart';

sealed class SignupGuestEvent extends Equatable {
  const SignupGuestEvent();

  @override
  List<Object> get props => [];
}

class SignupGuestSubmit extends SignupGuestEvent {
  const SignupGuestSubmit({
    required this.sex,
    required this.yearOfBirth,
  });

  final Sex sex;
  final int yearOfBirth;

  @override
  List<Object> get props => [
        sex,
        yearOfBirth,
      ];
}
