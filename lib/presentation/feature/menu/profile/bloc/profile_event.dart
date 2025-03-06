part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileChangeName extends ProfileEvent {
  const ProfileChangeName({
    required this.userId,
    required this.userName,
  });

  final String userId;
  final String userName;

  @override
  List<Object> get props => [
        userId,
        userName,
      ];
}
