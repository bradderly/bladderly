import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/domain/model/user.dart';
import 'package:bradderly/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> checkExistingUser({required String email}) {
    // TODO: implement checkExistingUser
    throw UnimplementedError();
  }

  @override
  Future<User> signin({required String email, required String password}) {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<User> signup({required String userId, required String email, required String password}) {
    // TODO: implement signup
    throw UnimplementedError();
  }

  @override
  Future<User> signupGuest({required Sex sex, required int yearOfBirth}) {
    // TODO: implement signupGuest
    throw UnimplementedError();
  }
}
