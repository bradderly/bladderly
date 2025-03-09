import 'package:bladderly/domain/exception/domain_exception.dart';

class PurchaseFailureException extends DomainException {
  const PurchaseFailureException({
    super.title,
    required super.message,
  });
}
