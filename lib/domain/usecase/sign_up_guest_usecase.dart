// Package imports:
// Project imports:
import 'package:bladderly/domain/exception/age_restriction_exception.dart';
import 'package:bladderly/domain/model/sex.dart';
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
      final thisYear = DateTime.now().year;
      final age = thisYear - yearOfBirth;

      if (age < 18) return const Left(AgeRestrictionException());

      final user = await _authRepository.signUpGuest(
        gender: gender,
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
