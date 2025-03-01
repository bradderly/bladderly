// Dart imports:
import 'dart:io';

// Package imports:
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_region/device_region.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';

@module
abstract class PackageDeviceInfoModule {
  @lazySingleton
  @preResolve
  Future<DeviceInfoModel> get deviceInfo async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final region = await DeviceRegion.getSIMCountryCode().catchError((_) => null);

    late final String deviceName;

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceName = androidInfo.model;
    } else {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceName = iosInfo.utsname.machine.replaceAll(',', '_');
    }

    return DeviceInfoModel(
      name: deviceName.replaceAll(
        RegExp('[^a-zA-Z0-9_]'),
        '',
      ),
      region: region ?? '',
    );
  }

  @lazySingleton
  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
}
