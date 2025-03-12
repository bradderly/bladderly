import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/domain/exception/not_supported_device_exception.dart';

enum DeviceSupportStatus {
  supported,
  unsupported,
  soonSupported,
  ;

  DomainException? get exception => switch (this) {
        unsupported => const NotSupportedDeviceException(),
        soonSupported => const NotSupportedDeviceException.soon(),
        _ => null,
      };
}
