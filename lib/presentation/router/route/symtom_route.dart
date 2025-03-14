import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/symptom/result/symptom_result_view.dart';
import 'package:bladderly/presentation/feature/symptom/scores/symptom_scores_builder.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_survey/symptom_survey_builder.dart';
import 'package:bladderly/presentation/router/page/modal_bottom_sheet_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SymptomScoresRoute extends GoRouteData {
  const SymptomScoresRoute();

  static final $parentNavigatorKey = SymptomShellRoute.$navigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SymptomScoresBuilder();
  }
}

class SymptomSurveyRouteExtra extends Equatable {
  const SymptomSurveyRouteExtra({
    required this.symptomSurveyModel,
  });

  final SymptomSurveyModel symptomSurveyModel;

  @override
  List<Object> get props => [
        symptomSurveyModel,
      ];
}

class SymptomSurveyRoute extends GoRouteData {
  const SymptomSurveyRoute({
    required this.$extra,
  });

  static final $parentNavigatorKey = SymptomShellRoute.$navigatorKey;

  final SymptomSurveyRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: SymptomSurveyBuilder(symptomSurveyModel: $extra!.symptomSurveyModel),
    );
  }
}

class SymptomResultRouteExtra extends Equatable {
  const SymptomResultRouteExtra({
    required this.score,
  });

  final Score score;

  @override
  List<Object> get props => [
        score,
      ];
}

class SymptomResultRoute extends GoRouteData {
  const SymptomResultRoute({
    required this.$extra,
  });

  static final $parentNavigatorKey = SymptomShellRoute.$navigatorKey;

  final SymptomResultRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: SymptomResultView(score: $extra!.score),
    );
  }
}

class SymptomShellRoute extends ShellRouteData {
  static final $navigatorKey = GlobalKey<NavigatorState>();

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state, Widget navigator) {
    return ModalBottomSheetPage<void>(
      key: state.pageKey,
      child: navigator,
    );
  }
}
