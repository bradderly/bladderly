import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/domain/model/user.dart';

abstract class AuthRepository {
  Future<void> signupGuest({
    required String userId,
    required Gender gender,
    required int yearOfBirth,
    required String region,
    required String device,
  });

  Future<bool> checkExistingUser({
    required String email,
  });

  Future<void> signin({
    required String email,
    required String password,
  });

  Future<void> signup({
    required String userId,
    required String email,
    required String password,
  });

  Stream<User> get userStream;
}
