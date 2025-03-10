// Package imports:
// Project imports:
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChangeUserNameUsecase {
  const ChangeUserNameUsecase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  Future<Either<Exception, void>> call({
    required String userId,
    required String userName,
  }) async {
    try {
      final user = _userRepository.getUserOrNullByUserId(userId);

      if (user == null) return const Left(NotFoundUserException(message: 'User not found'));

      final result = await _userRepository.changeName(
        userId: userId,
        userEmail: user.email,
        userName: userName,
      );

      _userRepository.saveUser(user.copyWith(name: userName));

      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception('An unknown error occurred'));
    }
  }
}
