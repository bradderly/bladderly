// Dart imports:
import 'dart:io';

enum SignUpMethod {
  E,
  G,
  A,
  N,
  ;

  factory SignUpMethod.of(String name) {
    return SignUpMethod.values.firstWhere(
      (element) => element.name == name,
      orElse: () => E,
    );
  }

  static List<SignUpMethod> get socialValues {
    return [
      if (Platform.isIOS) SignUpMethod.A,
      SignUpMethod.G,
    ];
  }
}
