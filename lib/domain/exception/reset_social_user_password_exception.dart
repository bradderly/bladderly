import 'package:bladderly/domain/exception/domain_exception.dart';

class ResetSocialUserPasswordException extends DomainException {
  factory ResetSocialUserPasswordException.fromMessage(String provider) {
    return switch (provider) {
      'apple' => const ResetSocialUserPasswordException.apple(),
      'google' => const ResetSocialUserPasswordException.google(),
      _ => throw Exception('Invalid provider: $provider'),
    };
  }

  const ResetSocialUserPasswordException.apple()
      : super(
          title: 'Apple PW title',
          message: 'Apple PW body',
          button: 'Apple PW button',
        );

  const ResetSocialUserPasswordException.google()
      : super(
          title: 'Google PW title',
          message: 'Google PW body',
          button: 'Google PW button',
        );
}
