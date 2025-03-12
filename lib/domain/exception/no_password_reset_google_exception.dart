import 'package:bladderly/domain/exception/domain_exception.dart';

class NoPasswordResetGoogleException extends DomainException {
  const NoPasswordResetGoogleException()
      : super(
          title: 'No Password Reset Needed',
          message: 'You signed up with Google. Try "Continue with Google" to log in.',
        );
}
