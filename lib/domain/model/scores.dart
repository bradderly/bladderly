import 'package:bladderly/domain/model/score.dart';

class Scores<T extends Score> {
  Scores({required List<T> list}) : _list = List<T>.unmodifiable(list);

  const Scores.empty() : _list = const [];

  final List<T> _list;

  Iterable<A> map<A>(A Function(T e) toElement) {
    return _list.map(toElement);
  }
}
