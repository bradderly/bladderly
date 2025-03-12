import 'package:bladderly/domain/exception/domain_exception.dart';

class UpdateNewVersionMustException extends DomainException {
  const UpdateNewVersionMustException()
      : super(
          title: 'Update Required to Continue',
          message:
              'We’ve made important improvements to Bladderly! To keep using the app smoothly, please update to the latest version.',
        );
}
