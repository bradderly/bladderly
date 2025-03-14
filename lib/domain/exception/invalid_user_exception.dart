// Project imports:
import 'package:bladderly/domain/exception/domain_exception.dart';

class InvalidUserException extends DomainException {
  const InvalidUserException()
      : super(
          title: 'Sign-in Failed',
          message: 'Please check your email address and password.',
        );
}
