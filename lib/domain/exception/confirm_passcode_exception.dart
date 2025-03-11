import 'package:bladderly/domain/exception/domain_exception.dart';

class ConfirmPasscodeException extends DomainException {
  const ConfirmPasscodeException()
      : super(
          title: 'Passcode failed 5 times title',
          message: 'Passcode failed 5 times body',
        );
}
