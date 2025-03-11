import 'package:bladderly/domain/exception/domain_exception.dart';

class NotSetFutureException extends DomainException {
  const NotSetFutureException()
      : super(
          message: 'Future time selection body',
        );
}
