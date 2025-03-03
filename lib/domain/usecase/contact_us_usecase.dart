// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:bladderly/domain/repository/auth_repository.dart';

@lazySingleton
class ContactUsUsecase {
  const ContactUsUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, String>> call({
    required String email,
    required String firstName,
    required String lastName,
    required String message,
    required String subject,
  }) async {
    try {
      final result = await _authRepository.contactUs(
        email: email,
        firstName: firstName,
        lastName: lastName,
        message: message,
        subject: subject,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception('An unknown error occurred'));
    }
  }
}
