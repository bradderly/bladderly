import 'package:equatable/equatable.dart';

class HistoryResult extends Equatable {
  const HistoryResult({
    required this.isDone,
    required this.result,
  });

  final bool isDone;
  final String? result;

  double? get volume {
    if (double.tryParse(result ?? '') case final double volume) {
      return (volume / 10).round() * 10;
    }

    return null;
  }

  @override
  List<Object?> get props => [
        isDone,
        result,
      ];
}
