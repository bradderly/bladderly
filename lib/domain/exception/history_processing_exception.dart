import 'package:bladderly/domain/exception/domain_exception.dart';
import 'package:bladderly/domain/model/history.dart';

class HistoryProcessingException extends DomainException {
  const HistoryProcessingException({
    required super.message,
    required this.history,
  });

  final History history;

  @override
  List<Object?> get props => [
        ...super.props,
        history,
      ];
}
