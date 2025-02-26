import 'dart:io';

enum SigninSocialMethodModel {
  google(text: 'Continue with Google'),
  apple(text: 'Continue with Apple'),
  ;

  const SigninSocialMethodModel({
    required this.text,
  });

  final String text;

  static List<SigninSocialMethodModel> get socialMethods {
    return [
      SigninSocialMethodModel.google,
      if (Platform.isIOS) SigninSocialMethodModel.apple,
    ];
  }
}
