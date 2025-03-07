import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/domain/model/app_version.dart';
import 'package:bladderly/domain/repository/config_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@LazySingleton(as: ConfigRepository)
class ConfigRepositryImpl implements ConfigRepository {
  const ConfigRepositryImpl({
    required ApiClient apiClient,
    required PackageInfo packageInfo,
  })  : _apiClient = apiClient,
        _packageInfo = packageInfo;

  final ApiClient _apiClient;
  final PackageInfo _packageInfo;

  @override
  Future<AppVersion> getAppVersion() async {
    final response = await _apiClient.getVersion(device: 'ios').then((value) => value.body!);

    return AppVersion(
      minVersion: response.minVersion!,
      latestVersion: response.latestVersion!,
      currentVersion: _packageInfo.version,
    );
  }

  @override
  Future<List<String>> getSupportedDevices() {
    return Future.value(
      [
        'development',
        'iPn8__',
        'iPn8p_',
        'iPnX__',
        'iPnXr_',
        'iPnXs_',
        'iPnXsM',
        'iPn11_',
        'iPn11p',
        'iPn11pM',
        'iPnSE2',
        'iPhone12_8',
        'iPn12mi',
        'iPn12_',
        'iPn12p',
        'iPn12pM',
        'iPhone14_2',
        'iPhone14_4',
        'iPhone14_5',
        'iPhone14_3',
        'iPn13p',
        'iPn13mi',
        'iPn13_',
        'iPn13pM',
        'iPhone14_6',
        'iPhone14_7',
        'iPhone14_8',
        'iPhone15_2',
        'iPhone15_3',
        'iPhone15_4',
        'iPhone15_5',
        'iPhone16_1',
        'iPhone16_2',
        'iPhone17_1',
        'iPhone17_2',
        'iPhone17_3',
        'iPhone17_4'
      ],
    );
  }
}
