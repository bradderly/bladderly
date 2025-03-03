part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class Profile extends ProfileEvent {
  const Profile({
    required this.email,
    required this.newPw,
    required this.oldPw,
  });

  final String email;
  final String newPw;
  final String oldPw;

  @override
  List<Object> get props => [
        email,
        newPw,
        oldPw,
      ];
}
