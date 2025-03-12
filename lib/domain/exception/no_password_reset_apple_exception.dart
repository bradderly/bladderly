import 'package:bladderly/domain/exception/domain_exception.dart';

class NoPasswordResetAppleException extends DomainException {
  const NoPasswordResetAppleException()
      : super(
          title: 'No Password Reset Needed',
          message: 'You signed up with Apple. Try "Continue with Apple" to log in.',
        );
}
