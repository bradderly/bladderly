import 'package:bladderly/domain/exception/domain_exception.dart';

class FailSignInException extends DomainException {
  const FailSignInException()
      : super(
          title: 'Sign-in failed title',
          message: 'Please check your email address and password.',
        );
}
