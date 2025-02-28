import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpGuestUsecase {
  const SignUpGuestUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, User>> call({
    required Gender gender,
    required int yearOfBirth,
  }) async {
    try {
      final user = await _authRepository.signUpGuest(
        gender: gender,
        yearOfBirth: yearOfBirth,
        signUpMethod: SignUpMethod.N,
      );

      return Right(user);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
