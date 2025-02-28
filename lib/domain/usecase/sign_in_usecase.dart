import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInUsecase {
  const SignInUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, void>> call({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authRepository.signIn(email: email, password: password);

      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception('An unknown error occurred'));
    }
  }
}
