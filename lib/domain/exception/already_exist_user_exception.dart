import 'package:bladderly/domain/exception/domain_exception.dart';

class AlreadyExistUserException extends DomainException {
  AlreadyExistUserException()
      : super(
          title: 'Sign-up failed title',
          message: 'Sign-up failed body',
        );
}
