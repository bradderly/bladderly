// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:crypto/crypto.dart';

class PasswordUtil {
  const PasswordUtil._();

  static String generatePassword(String email) {
    return sha1.convert(utf8.encode('${email}Ab1!')).toString();
  }
}
