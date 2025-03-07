part of 'app_config_bloc.dart';

sealed class AppConfigState extends Equatable {
  const AppConfigState({
    AppConfig? appConfig,
    Map<String, int>? versionMap,
  })  : _appConfig = appConfig,
        _versionMap = versionMap ?? const {};

  final AppConfig? _appConfig;
  final Map<String, int> _versionMap;

  AppVersion get appVersion => _appConfig!.appVersion;

  String get currentVersion => appVersion.currentVersion;

  String get updatedDate {
    final updatedAt = switch (_versionMap[appVersion.currentVersion]) {
      final int millisecondsSinceEpoch => DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch),
      _ => DateTime.now(),
    };
    return DateFormat('yyyy. MM').format(updatedAt);
  }

  @override
  List<Object?> get props => [
        _appConfig,
        _versionMap,
      ];
}

final class AppConfigInitial extends AppConfigState {
  const AppConfigInitial({
    super.appConfig,
    super.versionMap,
  }) : super();
}

final class AppConfigLoadInProgress extends AppConfigState {
  const AppConfigLoadInProgress({
    super.appConfig,
    super.versionMap,
  });
}

final class AppConfigLoadSuccess extends AppConfigState {
  const AppConfigLoadSuccess({
    required AppConfig super.appConfig,
    super.versionMap,
  });
}

final class AppConfigLoadFailure extends AppConfigState {
  const AppConfigLoadFailure({
    required this.exception,
    super.appConfig,
    super.versionMap,
  });

  final Exception exception;

  @override
  List<Object?> get props => [
        ...super.props,
        exception,
      ];
}
