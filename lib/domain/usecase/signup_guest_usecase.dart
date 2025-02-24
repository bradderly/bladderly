import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/domain/model/user.dart';
import 'package:bradderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignupGuestUsecase {
  const SignupGuestUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, User>> call({
    required Sex sex,
    required int yearOfBirth,
  }) async {
    try {
      final user = await _authRepository.signupGuest(
        sex: sex,
        yearOfBirth: yearOfBirth,
      );

      return Right(user);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
