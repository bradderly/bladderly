// Package imports:

// Project imports:
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpEmailUsecase {
  const SignUpEmailUsecase({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<Either<Exception, User>> call({
    required String userId,
    required String email,
    required String password,
    required String userName,
    required String disease,
  }) async {
    try {
      final user = _userRepository.getUserOrNullByUserId(userId)?.copyWith(
            email: email,
            name: userName,
            disease: disease,
            signUpMethod: SignUpMethod.E,
          );

      if (user == null) {
        throw const NotFoundUserException(message: 'not found user');
      }

      final newUserId = await _authRepository.signUp(
        userId: userId,
        email: user.email!,
        userName: user.name!,
        disease: user.disease!,
        gender: user.gender.name,
        yearOfBirth: '${user.yearOfBirth}',
        signUpMethod: SignUpMethod.E.name,
        password: password,
      );

      final migratedUser = _userRepository.migrateUser(
        userId: userId,
        user: user.copyWith(userId: newUserId),
      );

      return Right(migratedUser);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
