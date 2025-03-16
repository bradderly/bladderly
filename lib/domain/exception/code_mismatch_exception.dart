import 'package:bladderly/domain/exception/domain_exception.dart';

class CodeMismatchException extends DomainException {
  const CodeMismatchException()
      : super(title: 'Forgot password reset issue title', message: 'Forgot password reset issue body');
}
