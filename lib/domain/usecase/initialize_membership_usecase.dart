import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/domain/exception/network_not_connected_exception.dart';
import 'package:bladderly/domain/exception/not_found_user_exception.dart';
import 'package:bladderly/domain/model/membership.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InitializeMembershipUsecase {
  const InitializeMembershipUsecase({
    required UserRepository userRepository,
    required NetworkChecker networkChecker,
  })  : _userRepository = userRepository,
        _networkChecker = networkChecker;

  final UserRepository _userRepository;
  final NetworkChecker _networkChecker;

  Future<Either<Exception, Membership?>> call({
    required String userId,
  }) async {
    try {
      final localUserId = _userRepository.getLocalUserIdByUserId(userId);

      if (localUserId == null) throw const NotFoundUserException(message: 'User not found');

      if (!await _networkChecker.isConnected) {
        throw const NetworkNotConnectedException();
      }

      final membership = await _userRepository.getMembershipFromServer(
        userId: userId,
      );

      final savedMembership =
          membership == null ? null : _userRepository.saveMembership(localUserId: localUserId, membership: membership);

      return Right(savedMembership);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }
}
