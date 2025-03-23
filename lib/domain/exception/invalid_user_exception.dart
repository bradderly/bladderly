// Project imports:
import 'package:bladderly/domain/exception/domain_exception.dart';

class InvalidUserException extends DomainException {
  const InvalidUserException()
      : super(
          title: 'Sign-in failed title',
          message: 'Sign-in failed body',
        );

  const InvalidUserException.fromChangePw()
      : super(
          message: 'Password change failed body',
        );
}
