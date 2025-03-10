import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPasswordUsecase {
  const ResetPasswordUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, void>> call({
    required String email,
    required String password,
    required String verificationCode,
  }) async {
    try {
      await _authRepository.resetPassword(
        email: email,
        password: password,
        verificationCode: verificationCode,
      );

      return const Right(null);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
