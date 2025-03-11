import 'package:bladderly/domain/exception/domain_exception.dart';

class CheckPasswordException extends DomainException {
  const CheckPasswordException()
      : super(
          message: 'Password change failed body',
        );
}
