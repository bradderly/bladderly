import 'package:bladderly/domain/exception/domain_exception.dart';

class NotSupportedDeviceException extends DomainException {
  const NotSupportedDeviceException()
      : super(
          title: 'Unsupported device title',
          message: 'Unsupported device body',
        );

  const NotSupportedDeviceException.soon()
      : super(
          title: 'Upcoming supported device title',
          message: 'Upcoming supported device body',
        );
}
