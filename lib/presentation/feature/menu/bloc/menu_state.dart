part of 'menu_bloc.dart';

sealed class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

final class MenuInitial extends MenuState {
  const MenuInitial();
}

final class MenuInProgress extends MenuState {
  const MenuInProgress();
}

final class ChangePasswordSuccess extends MenuState {
  const ChangePasswordSuccess();
}

final class ChangePasswordFailure extends MenuState {
  const ChangePasswordFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
