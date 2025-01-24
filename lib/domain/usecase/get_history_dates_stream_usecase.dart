import 'package:bradderly/domain/repository/history_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHistoryDatesStreamUsecase {
  const GetHistoryDatesStreamUsecase({required HistoryRepository historyRepository})
      : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Stream<List<DateTime>> call({
    required String hashId,
  }) {
    return _historyRepository.getHistoryDatesStream(hashId);
  }
}
