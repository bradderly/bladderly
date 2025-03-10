import 'package:equatable/equatable.dart';

class SymptomSurveryAnswerModel extends Equatable {
  const SymptomSurveryAnswerModel({
    required this.questionId,
    required this.sequence,
    required this.text,
  });

  final int questionId;
  final int sequence;
  final String text;

  @override
  List<Object?> get props => [
        questionId,
        sequence,
        text,
      ];
}
