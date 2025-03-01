// Project imports:
import 'package:bladderly/domain/exception/domain_exception.dart';

class NotFoundAppleCredentialException extends DomainException {
  const NotFoundAppleCredentialException({
    required super.message,
  });
}
