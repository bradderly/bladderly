import 'dart:io';

import 'package:bladderly/data/api/client/api_client.dart';
import 'package:bladderly/domain/model/app_version.dart';
import 'package:bladderly/domain/repository/config_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
    final response =
        await _apiClient.getVersion(device: defaultTargetPlatform.name.toLowerCase()).then((value) => value.body!);

    late String build;
    if (Platform.isIOS) {
      build = _packageInfo.buildNumber;
    } else {
      try {
        final channel = MethodChannel('${_packageInfo.packageName}/customBuild');
        final buildNumber = await channel.invokeMethod('getBuildNumber');
        build = buildNumber.toString();
      } catch (e) {
        build = _packageInfo.buildNumber;
        print("Failed to get build number: '$e'.");
      }
    }

    return AppVersion(
      minVersion: response.minVer!,
      latestVersion: response.latestVer!,
      currentVersion: _packageInfo.version,
      currentBuild: build,
    );
  }

  @override
  Future<List<String>> getSupportedDevices() async {
    final response =
        await _apiClient.getSupportModels(os: Platform.isAndroid ? 'android' : 'ios').then((value) => value.body!);

    return response.models ?? [];
  }
}
