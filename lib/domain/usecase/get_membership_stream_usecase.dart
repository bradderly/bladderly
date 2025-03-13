import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMembershipStreamUsecase {
  const GetMembershipStreamUsecase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  Either<Exception, Stream<Membership?>> call(String userId) {
    try {
      final localUserId = _userRepository.getLocalUserIdByUserId(userId);

      if (localUserId == null) throw const NotFoundUserException(message: 'not found user');

      return Right(_userRepository.getMembershipStream(localUserId: localUserId));
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
