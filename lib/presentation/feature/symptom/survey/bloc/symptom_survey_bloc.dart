// Package imports:
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/score_type.dart';
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
        SymptomSurveySubmit() => _onSubmit(event, emit),
      },
      transformer: droppable(),
    );
  }

  final SendScoreResultUsecase _sendScoreResultUsecase;

  Future<void> _onSubmit(SymptomSurveySubmit event, Emitter<SymptomSurveyState> emit) async {
    emit(const SymptomSurveySubmitInProgress());

    final result = await _sendScoreResultUsecase(
      userId: event.userId,
      scoreType: event.scoreType,
      scoreValue: event.answers,
    );

    result.fold(
      (exception) => emit(SymptomSurveySubmitFailure(exception: exception)),
      (score) => emit(
        SymptomSurveySubmitSuccess(
          score: score,
        ),
      ),
    );
  }
}
