import 'package:bladderly/domain/model/score.dart';

class Scores<T extends Score> {
  Scores({required List<T> list}) : _list = List<T>.unmodifiable(list);

  const Scores.empty() : _list = const [];

  final List<T> _list;

  get scores => null;

  Iterable<A> map<A>(A Function(T e) toElement) {
    return _list.map(toElement);
  }

  // 수정된 부분: String을 반환하도록 변경
  String printScoreCount() {
    return 'Number of scores: ${_list.length}';
  }
}
