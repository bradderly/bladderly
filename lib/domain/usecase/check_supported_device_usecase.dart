import 'dart:io';

import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/domain/model/device_support_status.dart';
import 'package:bladderly/domain/repository/config_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckSupportedDeviceUsecase {
  const CheckSupportedDeviceUsecase({
    required ConfigRepository configRepository,
    required DeviceInfoModel deviceInfoModel,
  })  : _configRepository = configRepository,
        _deviceInfoModel = deviceInfoModel;

  final ConfigRepository _configRepository;
  final DeviceInfoModel _deviceInfoModel;

  Future<Either<Exception, DeviceSupportStatus>> call() async {
    try {
      final devices = await _configRepository.getSupportedDevices();

      final isSupportedDevice = Platform.isAndroid
          ? !_deviceInfoModel.name.toLowerCase().contains('moto')
          : devices.contains(_deviceInfoModel.name);

      final isSoonSupportedDevice = devices.contains('${_deviceInfoModel.name}-soon');

      if (isSoonSupportedDevice) return const Right(DeviceSupportStatus.soonSupported);

      if (!isSupportedDevice) return const Right(DeviceSupportStatus.unsupported);

      return const Right(DeviceSupportStatus.supported);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
