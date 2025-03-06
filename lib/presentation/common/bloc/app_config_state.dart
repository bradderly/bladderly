part of 'app_config_bloc.dart';

sealed class AppConfigState extends Equatable {
  const AppConfigState({
    AppConfig? appConfig,
  }) : _appConfig = appConfig;

  final AppConfig? _appConfig;

  AppVersion get appVersion => _appConfig!.appVersion;

  @override
  List<Object?> get props => [
        _appConfig,
      ];
}

final class AppConfigInitial extends AppConfigState {
  const AppConfigInitial() : super(appConfig: null);
}

final class AppConfigLoadInProgress extends AppConfigState {
  const AppConfigLoadInProgress({super.appConfig});
}

final class AppConfigLoadSuccess extends AppConfigState {
  const AppConfigLoadSuccess({
    required AppConfig super.appConfig,
  });
}

final class AppConfigLoadFailure extends AppConfigState {
  const AppConfigLoadFailure({
    required this.exception,
    super.appConfig,
  });

  final Exception exception;

  @override
  List<Object?> get props => [
        ...super.props,
        exception,
      ];
}
