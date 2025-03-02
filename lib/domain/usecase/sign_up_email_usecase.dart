// Package imports:

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';

@lazySingleton
class SignUpEmailUsecase {
  const SignUpEmailUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, User>> call({
    required String userId,
    required String email,
    required String password,
    required String userName,
    required String disease,
  }) async {
    try {
      final user = await _authRepository.signUp(
        userId: userId,
        email: email,
        password: password,
        userName: userName,
        disease: disease,
      );

      return Right(user);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
