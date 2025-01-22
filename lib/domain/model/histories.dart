import 'package:bradderly/domain/model/history.dart';
import 'package:collection/collection.dart';

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

  int get leakageFrequency => _list.where((element) => element.isLeakage).length;

  Duration get maxInterval {
    if (_list.isEmpty || _list.length == 1) return Duration.zero;

    return List.generate(length - 1, (index) => _list[index + 1].recordTime.difference(_list[index].recordTime))
        .sorted((a, b) => b.compareTo(a))
        .last;
  }

  Duration get minInterval {
    if (_list.isEmpty || _list.length == 1) return Duration.zero;

    return List.generate(length - 1, (index) => _list[index + 1].recordTime.difference(_list[index].recordTime))
        .sorted((a, b) => a.compareTo(b))
        .first;
  }

  int get maxVolume {
    if (_list.isEmpty) return 0;

    return _list.sorted((a, b) => b.recordVolume.compareTo(a.recordVolume)).first.recordVolume;
  }

  int get minVolume {
    if (_list.isEmpty) return 0;

    return _list.sorted((a, b) => a.recordVolume.compareTo(b.recordVolume)).first.recordVolume;
  }
}

extension IntakeHistoriesExtension on IntakeHistories {
  int get totalVolume => _list.fold(0, (previousValue, element) => previousValue + element.recordVolume);

  IntakeHistories filterByBeverageType(String beverageType) {
    return IntakeHistories(list: _list.where((element) => element.beverageType == beverageType).toList());
  }
}
