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

  Iterable<A> map<A>(A Function(T e) toElement) {
    return _list.map(toElement);
  }

  Map<DateTime, List<T>> groupByRecordTime() {
    return groupBy(_list, (element) => element.recordTime.copyWith(second: 0, millisecond: 0, microsecond: 0));
  }
}

extension VodingHistoriesExtension on VodingHistories {
  int get totalVolume => _list.fold(0, (previousValue, element) => previousValue + element.recordVolume);

  int get leakageFrequency => _list.where((element) => element.isLeakage).length;

  List<Duration> get _intervals {
    if (_list.isEmpty || _list.length == 1) return [];

    return List.generate(length - 1, (index) => _list[index + 1].recordTime.difference(_list[index].recordTime));
  }

  Duration get maxInterval {
    if (_list.isEmpty || _list.length == 1) return Duration.zero;

    return _intervals.sorted((a, b) => b.compareTo(a)).last;
  }

  Duration get minInterval {
    if (_list.isEmpty || _list.length == 1) return Duration.zero;

    return _intervals.sorted((a, b) => a.compareTo(b)).first;
  }

  Duration get meanInterval {
    if (_list.isEmpty || _list.length == 1) return Duration.zero;

    return Duration(
      milliseconds:
          _intervals.fold(0, (previousValue, element) => previousValue + element.inMilliseconds) ~/ (_intervals.length),
    );
  }

  int get maxVolume {
    if (_list.isEmpty) return 0;

    return _list.sorted((a, b) => b.recordVolume.compareTo(a.recordVolume)).first.recordVolume;
  }

  int get minVolume {
    if (_list.isEmpty) return 0;

    return _list.sorted((a, b) => a.recordVolume.compareTo(b.recordVolume)).first.recordVolume;
  }

  int get daytimeFrequency {
    return _list.where((element) => !element.isNocutria).length;
  }

  int get nighttimeFrequency {
    return _list.where((element) => element.isNocutria).length;
  }
}

extension IntakeHistoriesExtension on IntakeHistories {
  int get totalVolume => _list.fold(0, (previousValue, element) => previousValue + element.recordVolume);

  IntakeHistories filterByBeverageType(String beverageType) {
    return IntakeHistories(list: _list.where((element) => element.beverageType == beverageType).toList());
  }

  double getVolumeRateByBeverageType(String beverageType) {
    if (totalVolume <= 0) return 0;

    return filterByBeverageType(beverageType).totalVolume / totalVolume;
  }
}
