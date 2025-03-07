import 'package:bladderly/domain/exception/domain_exception.dart';

class PasswordAttemptsExceededException extends DomainException {
  const PasswordAttemptsExceededException()
      : super(
          title: 'Sign-in Failed',
          message: 'Too many sign-in attempts. Please try again in a few hours.',
        );
}
