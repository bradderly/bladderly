import 'dart:io';

import 'package:bradderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@module
abstract class PackageDeviceInfoModule {
  @preResolve
  Future<DeviceInfoModel> get deviceInfo async {
    final deviceInfoPlugin = DeviceInfoPlugin();

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
    );
  }

  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
}
