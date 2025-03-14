import 'package:bladderly/domain/exception/domain_exception.dart';

class NetworkNotConnectedException extends DomainException {
  NetworkNotConnectedException() : super(message: 'Please check your internet connection.');
}
