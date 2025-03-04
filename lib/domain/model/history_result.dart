import 'package:equatable/equatable.dart';

class HistoryResult extends Equatable {
  const HistoryResult({
    required this.isDone,
    required this.result,
  });

  final bool isDone;
  final String? result;

  int? get volume => int.tryParse(result ?? '');

  @override
  List<Object?> get props => [
        isDone,
        result,
      ];
}
