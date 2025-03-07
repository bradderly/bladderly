import 'package:bladderly/domain/model/app_config.dart';
import 'package:bladderly/domain/repository/config_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoadAppConfigUsecase {
  const LoadAppConfigUsecase({
    required ConfigRepository configRepository,
  }) : _configRepository = configRepository;

  final ConfigRepository _configRepository;

  Future<Either<Exception, AppConfig>> call() async {
    try {
      final appVersion = await _configRepository.getAppVersion();

      final appConfig = AppConfig(
        appVersion: appVersion,
      );

      return Right(appConfig);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
