// Package imports:
// Project imports:
import 'package:bladderly/domain/repository/history_repository.dart';
import 'package:bladderly/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ExportHistoriesUsecase {
  const ExportHistoriesUsecase({
    required UserRepository userRepository,
    required HistoryRepository historyRepository,
  })  : _userRepository = userRepository,
        _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;
  final UserRepository _userRepository;

  Future<Either<Exception, void>> call({
    required String userId,
    required String email,
    required List<DateTime> dates,
  }) async {
    try {
      final result = await _historyRepository.exportHistories(
        userId: userId,
        email: email,
        dates: dates,
      );
      final localUserId = _userRepository.getLocalUserIdByUserId(userId)!;
      final membership = _userRepository.getMembershipOrNullByLocalUserId(localUserId);
      if (membership != null) {
        if (!membership.isValid) {
          // only non-subscription user count
          final usedMembership = membership.useExport();
          _userRepository.saveMembership(localUserId: localUserId, membership: usedMembership);
        }
      }

      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
