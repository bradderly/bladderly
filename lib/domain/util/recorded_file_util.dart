// Dart imports:
import 'dart:io';

// Package imports:
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/user.dart';

@lazySingleton
class RecordedFileUtil {
  const RecordedFileUtil({
    required DeviceInfoModel deviceInfoModel,
    required PackageInfo packageInfo,
  })  : _deviceInfoModel = deviceInfoModel,
        _packageInfo = packageInfo;

  final DeviceInfoModel _deviceInfoModel;
  final PackageInfo _packageInfo;

  String generateFileName({
    required User user,
    required File file,
  }) {
    final recordTimeStr = file.path.split('/').last.split('.').first;

    return [
      user.id,
      recordTimeStr,
      _deviceInfoModel.name,
      _packageInfo.version.replaceAll('.', ''),
      switch (user.gender) {
        Gender.female => 'f',
        Gender.male => 'm',
      },
      'diary-null.m4a',
    ].join('-');
  }
}
