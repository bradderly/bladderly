import 'package:bradderly/domain/model/histories.dart';
import 'package:bradderly/domain/repository/history_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHistoriesStreamUsecase {
  const GetHistoriesStreamUsecase({required HistoryRepository historyRepository})
      : _historyRepository = historyRepository;

  final HistoryRepository _historyRepository;

  Stream<Histories> call({
    required String hashId,
    required DateTime dateTime,
  }) {
    return _historyRepository.getHistoriesStream(hashId: hashId, date: dateTime);
  }
}
