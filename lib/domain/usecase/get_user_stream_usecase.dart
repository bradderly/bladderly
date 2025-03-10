// Package imports:
// Project imports:
import 'package:bladderly/domain/model/user.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserStreamUsecase {
  const GetUserStreamUsecase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  Either<Exception, Stream<User?>> call() {
    try {
      final userStream = _userRepository.userStream;

      return Right(userStream);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
