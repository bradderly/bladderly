// Package imports:
// Project imports:
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserUsecase {
  const GetUserUsecase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  Either<Exception, User?> call(String userId) {
    try {
      final userStream = _userRepository.getUserOrNullByUserId(userId);

      return Right(userStream);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
