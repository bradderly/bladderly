part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashCheckSupportedDeviceInProgress extends SplashState {}

final class SplashCheckSupportedDeviceSuccess extends SplashState {}

final class SplashCheckSupportedDeviceFailure extends SplashState {
  const SplashCheckSupportedDeviceFailure({
    required this.exception,
  });

  final Exception exception;

  @override
  List<Object> get props => [
        ...super.props,
        exception,
      ];
}
