import 'package:bladderly/domain/exception/domain_exception.dart';

class AgeRestrictionException extends DomainException {
  const AgeRestrictionException()
      : super(
          title: 'You Must Be 18 or Older',
          message: 'Sorry, but you need to be at least 18 to sign up. We hope to see you again in the future!',
        );
}
