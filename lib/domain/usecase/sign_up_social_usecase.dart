import 'package:bladderly/domain/model/sex.dart';
import 'package:bladderly/domain/model/sign_up_method.dart';
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:bladderly/domain/util/password_util.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpSocialUsecase {
  const SignUpSocialUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, User>> call({
    required SignUpMethod signUpMethod,
    required Gender gender,
    required int yearOfBirth,
    required String email,
    required String userName,
    required String disease,
  }) async {
    try {
      final user = await _authRepository.signUpSocial(
        signUpMethod: signUpMethod,
        gender: gender,
        yearOfBirth: yearOfBirth,
        email: email,
        password: PasswordUtil.generatePassword(email),
        userName: userName,
        disease: disease,
      );

      return Right(user);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
