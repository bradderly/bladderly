part of 'app_config_bloc.dart';

sealed class AppConfigState extends Equatable {
  const AppConfigState({
    AppConfig? appConfig,
    Map<String, int>? versionMap,
    List<String>? latestVersions,
  })  : _appConfig = appConfig,
        _versionMap = versionMap ?? const {},
        _latestVersions = latestVersions ?? const [];

  final AppConfig? _appConfig;
  final Map<String, int> _versionMap;
  final List<String> _latestVersions;

  String get storeUrl => Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=com.soundable.diaryandroid.us'
      : 'https://apps.apple.com/app/id1523268654';

  AppVersion get appVersion => _appConfig!.appVersion;

  String get currentVersion => appVersion.currentVersion;
  String get currentBuild => kDebugMode ? ' (${appVersion.currentBuild})' : '';

  bool get needForceUpdate {
    return _compareVersions(appVersion.currentVersion, appVersion.minVersion) < 0;
  }

  bool get needSoftUpdate {
    return _compareVersions(appVersion.currentVersion, appVersion.latestVersion) < 0;
  }

  int _compareVersions(String version1, String version2) {
    final v1 = version1.split('.').map(int.parse).toList();
    final v2 = version2.split('.').map(int.parse).toList();

    for (var i = 0; i < v1.length; i++) {
      if (v1[i] < v2[i]) return -1;
      if (v1[i] > v2[i]) return 1;
    }
    return 0;
  }

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
        _latestVersions,
      ];
}

final class AppConfigInitial extends AppConfigState {
  const AppConfigInitial({
    super.appConfig,
    super.versionMap,
    super.latestVersions,
  }) : super();
}

final class AppConfigLoadInProgress extends AppConfigState {
  const AppConfigLoadInProgress({
    super.appConfig,
    super.versionMap,
    super.latestVersions,
  });
}

final class AppConfigLoadSuccess extends AppConfigState {
  const AppConfigLoadSuccess({
    required AppConfig super.appConfig,
    super.versionMap,
    super.latestVersions,
  });
}

final class AppConfigLoadFailure extends AppConfigState {
  const AppConfigLoadFailure({
    required this.exception,
    super.appConfig,
    super.versionMap,
    super.latestVersions,
  });

  final Exception exception;

  @override
  List<Object?> get props => [
        ...super.props,
        exception,
      ];
}
