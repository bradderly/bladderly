import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/domain/model/app_config.dart';
import 'package:bladderly/domain/model/app_version.dart';
import 'package:bladderly/domain/repository/config_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@lazySingleton
class LoadAppConfigUsecase {
  const LoadAppConfigUsecase({
    required ConfigRepository configRepository,
    required NetworkChecker networkChecker,
    required PackageInfo packageInfo,
  })  : _configRepository = configRepository,
        _networkChecker = networkChecker,
        _packageInfo = packageInfo;

  final ConfigRepository _configRepository;
  final NetworkChecker _networkChecker;
  final PackageInfo _packageInfo;

  Future<Either<Exception, AppConfig>> call() async {
    try {
      final emptyAppVersion = AppVersion.empty(
        currentVersion: _packageInfo.version,
        currentBuild: _packageInfo.buildNumber,
      );

      final appVersion = await _networkChecker.isConnected.then(
        (isConnected) => isConnected ? _configRepository.getAppVersion() : Future<AppVersion>.value(emptyAppVersion),
      );

      final appConfig = AppConfig(appVersion: appVersion);

      return Right(appConfig);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
