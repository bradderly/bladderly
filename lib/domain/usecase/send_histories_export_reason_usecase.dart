import 'package:bradderly/domain/repository/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendHistoriesExportReasonUsecase {
  const SendHistoriesExportReasonUsecase({
    required HistoryRepository historyRepository,
  }) : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Future<Either<Exception, void>> call({
    required String userId,
    required String? doctorName,
    required String? clinicInformation,
  }) async {
    try {
      final result = await _historyRepository.sendHistoriesExportReason(
        userId: userId,
        doctorName: doctorName,
        clinicInformation: clinicInformation,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
