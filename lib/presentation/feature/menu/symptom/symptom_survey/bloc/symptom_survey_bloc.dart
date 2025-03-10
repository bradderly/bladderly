// Package imports:
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/usecase/send_score_result_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'symptom_survey_event.dart';
part 'symptom_survey_state.dart';

class SymptomSurveyBloc extends Bloc<SymptomSurveyEvent, SymptomSurveyState> {
  SymptomSurveyBloc({
    required SendScoreResultUsecase sendScoreResultUsecase,
  })  : _sendScoreResultUsecase = sendScoreResultUsecase,
        super(const SymptomSurveyInitial()) {
    on<SymptomSurveyEvent>(
      (event, emit) => switch (event) {
        SymptomSurvey() => _onSendScore(event, emit),
      },
      transformer: droppable(),
    );
  }

  final SendScoreResultUsecase _sendScoreResultUsecase;

  Future<void> _onSendScore(SymptomSurvey event, Emitter<SymptomSurveyState> emit) async {
    emit(const SymptomSurveyProgress());

    final result = await _sendScoreResultUsecase(
      userId: event.userId,
      scoreName: event.score.type,
      scoreDate: event.score.date,
      scoreValue: event.score.values,
    );

    result.fold(
      (exception) => emit(SymptomSurveyFailure(exception: exception)),
      (success) => emit(const SymptomSurveySuccess()),
    );
  }
}
