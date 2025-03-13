import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_question_model.dart';
import 'package:equatable/equatable.dart';

class SymptomSurveyQuestionsModel extends Equatable {
  SymptomSurveyQuestionsModel._({required List<SymptomSurveyQuestionModel> list})
      : _list = List<SymptomSurveyQuestionModel>.unmodifiable(list);

  factory SymptomSurveyQuestionsModel.ipssQ() {
    return SymptomSurveyQuestionsModel._(
      list: List.generate(
        8,
        (index) => SymptomSurveyQuestionModel.ipss(
          id: index,
          answerCount: switch (index) {
            7 => 7,
            _ => 6,
          },
        ),
      ),
    );
  }

  factory SymptomSurveyQuestionsModel.oabss() {
    return SymptomSurveyQuestionsModel._(
      list: List.generate(
        4,
        (index) => SymptomSurveyQuestionModel.oabss(
          id: index,
          answerCount: switch (index) {
            0 => 3,
            1 => 4,
            _ => 6,
          },
        ),
      ),
    );
  }

  final List<SymptomSurveyQuestionModel> _list;

  int get length => _list.length;

  SymptomSurveyQuestionModel operator [](int index) => _list[index];

  List<String> get titles => _list.map((e) => e.title).toList();

  List<String> get contents => _list.map((e) => e.content).toList();

  @override
  List<Object?> get props => [
        _list,
      ];
}
