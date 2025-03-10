import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/score_type.dart';

class Scores {
  Scores({required List<Score> list}) : _list = List<Score>.unmodifiable(list);

  const Scores.empty() : _list = const [];

  final List<Score> _list;

  Scores whereByScoreType(ScoreType scoreType) =>
      Scores(list: _list.where((scroe) => scroe.type == scoreType).toList());

  bool get isNotEmpty => _list.isNotEmpty;

  int get length => _list.length;

  Score operator [](int index) => _list[index];

  List<T> map<T>(T Function(Score) f) => _list.map(f).toList();
}
