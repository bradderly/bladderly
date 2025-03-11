import 'package:bladderly/domain/exception/domain_exception.dart';

class NoPermissionMicException extends DomainException {
  const NoPermissionMicException()
      : super(
          title: 'Microphone permission title',
          message: 'Microphone permission body',
        );
}
