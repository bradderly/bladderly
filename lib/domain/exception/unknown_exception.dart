import 'package:bladderly/domain/exception/domain_exception.dart';

class UnknownException extends DomainException {
  const UnknownException({required super.message});
}
