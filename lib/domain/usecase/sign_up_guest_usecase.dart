// Package imports:
// Project imports:
import 'package:bladderly/domain/exception/age_restriction_exception.dart';
import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpGuestUsecase {
  const SignUpGuestUsecase({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<Either<Exception, User>> call({
    required Gender gender,
    required int yearOfBirth,
  }) async {
    try {
      final thisYear = DateTime.now().year;
      final age = thisYear - yearOfBirth;

      if (yearOfBirth < 1901) return const Left(AgeRestrictionException.upperBound());

      if (age < 19) return const Left(AgeRestrictionException.lowerBound());

      final user = await _authRepository.signUpGuest(
        gender: gender,
        yearOfBirth: yearOfBirth,
      );

      _userRepository.saveUser(user);

      return Right(user);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
