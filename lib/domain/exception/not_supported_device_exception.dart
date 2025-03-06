import 'package:bladderly/domain/exception/domain_exception.dart';

class NotSupportedDeviceException extends DomainException {
  const NotSupportedDeviceException()
      : super(
          title: 'Model not supported',
          message:
              'The device is not supported. All features are available, but measurement accuracy is not guaranteed. You can check the supported devices on the App Store Page or the website.',
        );

  const NotSupportedDeviceException.soon()
      : super(
          title: 'New iPhone!',
          message: '''We're finalizing compatibility for the recording feature on the new iPhone series. Stay tuned!''',
        );
}
