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

class GetVersionSuccess extends MenuState {
  const GetVersionSuccess({required this.latestVersion});
  final String latestVersion;
}

final class GetVersionFailure extends MenuState {
  const GetVersionFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
