part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileChangeNameInProgress extends ProfileState {
  const ProfileChangeNameInProgress();
}

final class ProfileChangeNameSuccess extends ProfileState {
  const ProfileChangeNameSuccess();
}

final class ProfileChangeNameFailure extends ProfileState {
  const ProfileChangeNameFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
