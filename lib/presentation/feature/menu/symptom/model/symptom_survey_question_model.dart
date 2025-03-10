import 'package:bladderly/presentation/feature/menu/symptom/model/symptom_survery_answer_model.dart';
import 'package:equatable/equatable.dart';

class SymptomSurveyQuestionModel extends Equatable {
  const SymptomSurveyQuestionModel._({
    required this.id,
    required this.title,
    required this.content,
    required this.answers,
  });

  factory SymptomSurveyQuestionModel.ipss({
    required int id,
    required int answerCount,
  }) {
    return SymptomSurveyQuestionModel._(
      id: id,
      title: 'IPSS Title ${id + 1}',
      content: 'IPSS${id + 1}',
      answers: List.generate(
        answerCount,
        (index) => SymptomSurveryAnswerModel(
          questionId: id,
          sequence: index,
          text: 'IPSS${id + 1}_answer$index',
        ),
      ),
    );
  }

  factory SymptomSurveyQuestionModel.oabss({
    required int id,
    required int answerCount,
  }) {
    return SymptomSurveyQuestionModel._(
      id: id,
      title: 'OABSS Title ${id + 1}',
      content: 'OABSS${id + 1}',
      answers: List.generate(
        answerCount,
        (index) => SymptomSurveryAnswerModel(
          questionId: id,
          sequence: index,
          text: 'OABSS${id + 1}_answer$index',
        ),
      ),
    );
  }

  final int id;
  final String title;
  final String content;
  final List<SymptomSurveryAnswerModel> answers;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        answers,
      ];
}
