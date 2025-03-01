import 'package:bladderly/domain/exception/domain_exception.dart';

class InvalidUserException extends DomainException {
  const InvalidUserException({required super.message});
}
