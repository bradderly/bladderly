import 'package:bladderly/domain/exception/domain_exception.dart';

class UpdateNewVersionException extends DomainException {
  const UpdateNewVersionException()
      : super(
          title: 'A New Version is Here!',
          message: 'We’ve made some improvements to Bladderly! Update now for the best experience.',
        );
}
