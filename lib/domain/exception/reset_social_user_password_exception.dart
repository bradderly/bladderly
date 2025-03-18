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
          title: 'No Password Reset Needed',
          message: 'You signed up with Apple. Try "Continue with Apple" to log in.',
        );

  const ResetSocialUserPasswordException.google()
      : super(
          title: 'No Password Reset Needed',
          message: 'You signed up with Google. Try "Continue with Google" to log in.',
        );
}
