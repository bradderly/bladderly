import 'package:bladderly/domain/exception/reset_social_user_password_exception.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendVerificationCodeUsecase {
  const SendVerificationCodeUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, void>> call({
    required String email,
  }) async {
    try {
      final message = await _authRepository.sendVerificationCode(email: email);

      if (message == 'success') return const Right(null);

      return Left(ResetSocialUserPasswordException.fromMessage(message));
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
