import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInSocialUsecase {
  const SignInSocialUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, String>> call({
    required SignUpMethod signUpMethod,
  }) async {
    try {
      final email = await switch (signUpMethod) {
        SignUpMethod.G => _authRepository.signInGoogle(),
        SignUpMethod.A => _authRepository.signInApple(),
        _ => throw UnsupportedError('Unsupported sign up method: $signUpMethod'),
      };

      return Right(email);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception('An unknown error occurred'));
    }
  }
}
