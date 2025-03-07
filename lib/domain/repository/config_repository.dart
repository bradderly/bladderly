import 'package:bladderly/domain/model/app_version.dart';

abstract class ConfigRepository {
  const ConfigRepository._();

  Future<AppVersion> getAppVersion();

  Future<List<String>> getSupportedDevices();
}
