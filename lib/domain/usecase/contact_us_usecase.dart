// Package imports:
// Project imports:
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ContactUsUsecase {
  const ContactUsUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, String>> call({
    required String userId,
    required String userEmail,
    required String userName,
    required String message,
  }) async {
    try {
      final result = await _authRepository.contactUs(
        userId: userId,
        userEmail: userEmail,
        userName: userName,
        message: message,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception('An unknown error occurred'));
    }
  }
}
