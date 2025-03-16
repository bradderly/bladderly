import 'package:bladderly/domain/exception/domain_exception.dart';

class NetworkNotConnectedException extends DomainException {
  const NetworkNotConnectedException() : super(message: 'Please check your internet connection.');
}
