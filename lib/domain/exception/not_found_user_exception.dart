// Project imports:
import 'package:bladderly/domain/exception/domain_exception.dart';

class NotFoundUserException extends DomainException {
  const NotFoundUserException({
    required super.message,
  });
}
