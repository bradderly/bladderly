import 'package:bradderly/domain/model/sex.dart';
import 'package:bradderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignupGuestUsecase {
  const SignupGuestUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, void>> call({
    required String userId,
    required Gender gender,
    required int yearOfBirth,
    required String region,
    required String device,
  }) async {
    try {
      await _authRepository.signupGuest(
        userId: userId,
        gender: gender,
        yearOfBirth: yearOfBirth,
        region: region,
        device: device,
      );

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
