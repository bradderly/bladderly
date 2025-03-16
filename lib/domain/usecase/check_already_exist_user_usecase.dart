import 'package:bladderly/domain/exception/invalid_user_exception.dart';
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/exception/password_attempts_exceeded_exception.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckAlreadyExistUserUsecase {
  const CheckAlreadyExistUserUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, bool>> call({
    required String email,
  }) async {
    try {
      await _authRepository.signIn(
        email: email,
        password: '961B6DD3EDE3CB8ECBAACBD68DE040CD78EB2ED5889130CCEB4C49268EA4D506',
      );

      return const Right(true);
    } catch (e) {
      if (e is NotFoundUserException) {
        return const Right(false);
      }

      if (e is InvalidUserException || e is PasswordAttemptsExceededException) {
        return const Right(true);
      }

      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
