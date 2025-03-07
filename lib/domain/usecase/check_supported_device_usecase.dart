import 'package:bladderly/core/package_device_info/src/model/device_info_model.dart';
import 'package:bladderly/domain/exception/not_supported_device_exception.dart';
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

  Future<Either<Exception, void>> call() async {
    try {
      final devices = await _configRepository.getSupportedDevices();

      final isSupportedDevice = devices.contains(_deviceInfoModel.name);

      final isSoonSupportedDevice = devices.contains('${_deviceInfoModel.name}-soon');

      if (isSoonSupportedDevice) {
        return const Left(NotSupportedDeviceException.soon());
      }

      if (!isSupportedDevice) {
        return const Left(NotSupportedDeviceException());
      }

      return const Right(null);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
