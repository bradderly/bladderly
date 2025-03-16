import 'dart:async';

import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/domain/model/score_type.dart';
import 'package:bladderly/presentation/feature/symptom/detail/symptom_detail_modal.dart';
import 'package:bladderly/presentation/feature/symptom/introduce/symptom_introduce_view.dart';
import 'package:bladderly/presentation/feature/symptom/reference/symptom_reference_view.dart';
import 'package:bladderly/presentation/feature/symptom/result/symptom_result_view.dart';
import 'package:bladderly/presentation/feature/symptom/scores/symptom_scores_view.dart';
import 'package:bladderly/presentation/feature/symptom/survey/symptom_survey_builder.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_builder.dart';
import 'package:bladderly/presentation/router/page/modal_bottom_sheet_page.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SymptomScoresRoute extends GoRouteData {
  const SymptomScoresRoute();

  static final $parentNavigatorKey = SymptomShellRoute.$navigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SymptomScoresView();
  }
}

class SymptomSurveyRoute extends GoRouteData {
  const SymptomSurveyRoute({
    required this.scoreType,
  });

  static final $parentNavigatorKey = SymptomShellRoute.$navigatorKey;

  final ScoreType scoreType;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: SymptomSurveyBuilder(scoreType: scoreType),
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
      builder: (context) => SymptomBuilder(navigator: navigator),
    );
  }
}

class SymptomReferenceRoute extends GoRouteData {
  const SymptomReferenceRoute();

  static final $parentNavigatorKey = SymptomShellRoute.$navigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const SymptomReferenceView(),
    );
  }
}

class SymptomDetailRouteExtra extends Equatable {
  const SymptomDetailRouteExtra({
    required this.score,
  });

  final Score score;

  @override
  List<Object> get props => [
        score,
      ];
}

class SymptomDetailRoute extends GoRouteData {
  const SymptomDetailRoute({
    required this.$extra,
  });

  static final $parentNavigatorKey = SymptomShellRoute.$navigatorKey;

  final SymptomDetailRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: SymptomDetailView(
        score: $extra!.score,
      ),
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if ($extra == null) return const SymptomScoresRoute().location;

    return super.redirect(context, state);
  }
}

class SymptomIntroduceRoute extends GoRouteData {
  const SymptomIntroduceRoute({required this.scoreType});

  final ScoreType scoreType;
  static final $parentNavigatorKey = SymptomShellRoute.$navigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: SymptomIntroduceView(
        scoreType: scoreType,
      ),
    );
  }
}
