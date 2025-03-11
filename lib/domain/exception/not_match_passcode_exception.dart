import 'package:bladderly/domain/exception/domain_exception.dart';

class NotMatchPasscodeException extends DomainException {
  const NotMatchPasscodeException()
      : super(
          title: 'Forgot password reset issue title',
          message: 'Forgot password reset issue body',
        );
}
