import 'package:bradderly/domain/model/history.dart';

typedef VodingHistories = Histories<VoidingHistory>;

typedef IntakeHistories = Histories<IntakeHistory>;

typedef LeakageHistories = Histories<LeakageHistory>;

class Histories<T extends History> {
  Histories({required List<T> list}) : _list = List<T>.unmodifiable(list);

  const Histories.empty() : _list = const [];

  final List<T> _list;

  VodingHistories get voidings => Histories(list: _list.whereType<VoidingHistory>().toList());

  IntakeHistories get intakes => Histories(list: _list.whereType<IntakeHistory>().toList());

  LeakageHistories get leakages => Histories(list: _list.whereType<LeakageHistory>().toList());

  int get length => _list.length;

  bool get isEmpty => _list.isEmpty;

  DateTime? get lastRecordTime => _list.isEmpty ? null : _list.last.recordTime;
}

extension VodingHistoriesExtension on VodingHistories {
  int get totalVolume => _list.fold(0, (previousValue, element) => previousValue + element.recordVolume);
}

extension IntakeHistoriesExtension on IntakeHistories {
  int get totalVolume => _list.fold(0, (previousValue, element) => previousValue + element.recordVolume);
}
