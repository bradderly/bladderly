import 'package:bladderly/domain/exception/domain_exception.dart';

class NetworkNotConnectedException extends DomainException {
  const NetworkNotConnectedException() : super(message: 'Network issue body');
}
