import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/domain/model/user.dart';

abstract class AuthRepository {
  Future<User> signupGuest({
    required Sex sex,
    required int yearOfBirth,
  });

  Future<bool> checkExistingUser({
    required String email,
  });

  Future<User> signin({
    required String email,
    required String password,
  });

  Future<User> signup({
    required String userId,
    required String email,
    required String password,
  });
}
