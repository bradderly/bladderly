// Package imports:
// Project imports:
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChangeUserNameUsecase {
  const ChangeUserNameUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<Exception, void>> call({
    required String userId,
    required String userName,
  }) async {
    try {
      final user = _authRepository.getUserOrNullByUserId(userId);

      if (user == null) return const Left(NotFoundUserException(message: 'User not found'));

      final result = await _authRepository.changeName(
        userId: userId,
        userEmail: user.email,
        userName: userName,
      );

      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception('An unknown error occurred'));
    }
  }
}
