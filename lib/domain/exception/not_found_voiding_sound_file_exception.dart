// Project imports:
import 'package:bladderly/domain/exception/domain_exception.dart';

class NotFoundVoidingSoundFileException extends DomainException {
  const NotFoundVoidingSoundFileException({
    required super.message,
  });
}
