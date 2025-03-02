// Project imports:
import 'package:bladderly/domain/exception/domain_exception.dart';

class NotFoundUserIdentifierException extends DomainException {
  const NotFoundUserIdentifierException({
    required super.message,
  });
}
