// Flutter imports:

// Project imports:
import 'dart:async';

import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/domain/model/score.dart';
import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:bladderly/presentation/feature/about/privacy/privacy_view.dart';
import 'package:bladderly/presentation/feature/about/terms/terms_view.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/detailed_list_builder.dart';
import 'package:bladderly/presentation/feature/export/export_builder.dart';
import 'package:bladderly/presentation/feature/input/intake_input/intake_input_builder.dart';
import 'package:bladderly/presentation/feature/input/manual_input/manual_input_builder.dart';
import 'package:bladderly/presentation/feature/input/sound_input_note/sound_input_note_builder.dart';
import 'package:bladderly/presentation/feature/input/sound_input_recording/sound_input_recording_builder.dart';
import 'package:bladderly/presentation/feature/main/main_builder.dart';
import 'package:bladderly/presentation/feature/menu/faq/faq_view_modal.dart';
import 'package:bladderly/presentation/feature/menu/menu_builder.dart';
import 'package:bladderly/presentation/feature/payment/paywall/paywall_builder.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/sign_up_regular_builder.dart';
import 'package:bladderly/presentation/feature/symptom/model/symptom_survey_model.dart';
import 'package:bladderly/presentation/feature/symptom/result/symptom_result_view.dart';
import 'package:bladderly/presentation/feature/symptom/scores/symptom_scores_builder.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_survey/symptom_survey_builder.dart';
import 'package:bladderly/presentation/feature/symptom/symptom_view.dart';
import 'package:bladderly/presentation/feature/tutorial/guide_tour/guide_tour_view.dart';
import 'package:bladderly/presentation/feature/tutorial/how_to_use/how_to_use_view.dart';
import 'package:bladderly/presentation/router/page/dialog_page.dart';
import 'package:bladderly/presentation/router/page/modal_bottom_sheet_page.dart';
// Package imports:
import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part 'main_route.g.dart';

enum MainRouteTab {
  home,
  diary,
  ;
}

@TypedGoRoute<MainRoute>(
  name: 'main',
  path: '/',
  routes: [
    TypedGoRoute<GuideTourRoute>(
      name: 'guide-tour',
      path: 'guide-tour',
    ),
    TypedGoRoute<ExportRoute>(
      name: 'export',
      path: 'export',
    ),
    TypedGoRoute<MenuRoute>(
      path: 'menu',
      name: 'menu',
      routes: [
        TypedGoRoute<SignUpRegularRoute>(path: 'sign-up', name: 'sign-up-regular'),
        TypedGoRoute<TermsRoute>(path: 'terms', name: 'terms'),
        TypedGoRoute<PrivacyRoute>(path: 'privacy', name: 'privacy'),
        TypedGoRoute<FaqRoute>(path: 'faq', name: 'faq'),
        TypedGoRoute<PaywallRoute>(
          name: 'paywall',
          path: 'paywall',
        ),
        TypedShellRoute<SymptomShellRouteData>(
          routes: [
            TypedGoRoute<SymptomScoresRoute>(
              path: 'symptom-scores',
              name: 'symptom-scores',
              routes: [
                TypedGoRoute<SymptomSurveyRoute>(
                  path: 'symptom-survey',
                  name: 'symptom-survey',
                ),
                TypedGoRoute<SymptomResultRoute>(
                  path: 'symptom-result',
                  name: 'symptom-result',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedGoRoute<SoundInputRecordingRoute>(
      name: 'sound-input-recording',
      path: 'sound-input-recording',
    ),
    TypedGoRoute<SoundInputNoteRoute>(
      name: 'sound-input-note',
      path: 'sound-input-note',
    ),
    TypedGoRoute<ManualInputRoute>(
      name: 'manual-input',
      path: 'manual-input',
    ),
    TypedGoRoute<IntakeInputRoute>(
      name: 'intake-input',
      path: 'intake-input',
    ),
    TypedGoRoute<DetailedListRoute>(
      name: 'detailed-list',
      path: 'detailed-list',
    ),
    TypedGoRoute<HowToUseRoute>(
      name: 'how-to-use',
      path: 'how-to-use',
    ),
  ],
)
class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const MainBuilder(),
    );
  }
}

class ExportRoute extends GoRouteData {
  const ExportRoute({
    List<DateTime>? historyDates,
  }) : historyDates = historyDates ?? const [];

  final List<DateTime> historyDates;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: ExportBuilder(historyDates: historyDates),
    );
  }
}

class SoundInputRecordingRoute extends GoRouteData {
  const SoundInputRecordingRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: const SoundInputRecordingBuilder(),
    );
  }
}

class SoundInputNoteRoute extends GoRouteData {
  const SoundInputNoteRoute({
    required this.recordTime,
  });

  final DateTime recordTime;
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: SoundInputNoteBuilder(
        recordTime: recordTime,
      ),
    );
  }
}

class SoundInputNoteRouteExtra extends Equatable {
  const SoundInputNoteRouteExtra({
    required this.recordTime,
  });

  final DateTime recordTime;

  @override
  List<Object> get props => [
        recordTime,
      ];
}

class ManualInputRouteExtra extends Equatable {
  const ManualInputRouteExtra({
    required this.history,
  });

  final History history;

  @override
  List<Object> get props => [
        history,
      ];
}

class ManualInputRoute extends GoRouteData {
  const ManualInputRoute({
    this.recordTime,
  });

  final DateTime? recordTime;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: ManualInputBuilder(
        recordTime: recordTime,
      ),
    );
  }
}

class IntakeInputRouteExtra extends Equatable {
  const IntakeInputRouteExtra({
    required this.intakeHistory,
  });

  final IntakeHistory intakeHistory;

  @override
  List<Object> get props => [
        intakeHistory,
      ];
}

class IntakeInputRoute extends GoRouteData {
  const IntakeInputRoute({
    required this.beverageType,
    required this.recordTime,
  });

  const IntakeInputRoute.fromBeverageType({
    required BeverageTypeModel beverageType,
  }) : this(beverageType: beverageType, recordTime: null);

  const IntakeInputRoute.fromRecordTime({
    required DateTime recordTime,
  }) : this(beverageType: null, recordTime: recordTime);

  final BeverageTypeModel? beverageType;
  final DateTime? recordTime;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: IntakeInputBuilder(
        beverageTypeModel: beverageType,
        recordTime: recordTime,
      ),
    );
  }
}

class DetailedListRoute extends GoRouteData {
  const DetailedListRoute({
    required this.date,
    required this.historyId,
  });

  final DateTime date;
  final int historyId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: DetailedListBuilder(
        date: date,
        historyId: historyId,
      ),
    );
  }
}

class PaywallRouteExtra extends Equatable {
  const PaywallRouteExtra({
    required this.plans,
  });

  final List<Plan> plans;

  @override
  List<Object> get props => [
        plans,
      ];
}

class PaywallRoute extends GoRouteData {
  const PaywallRoute({
    required this.$extra,
  });

  final PaywallRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: PaywallBuilder(
          plans: $extra?.plans ?? [],
        ),
      );

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if ($extra == null) {
      return const MenuRoute().location;
    }

    return super.redirect(context, state);
  }
}

class SignUpRegularRoute extends GoRouteData {
  const SignUpRegularRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const SignUpRegularBuilder(),
    );
  }
}

class MenuRoute extends GoRouteData {
  const MenuRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: const MenuBuilder(),
    );
  }
}

class HowToUseRoute extends GoRouteData {
  const HowToUseRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage(
      key: state.pageKey,
      fullscreenDialog: true,
      child: const HowtouseView(),
    );
  }

  Future<bool?> push(BuildContext context) => context.push<bool>(location);
}

class TermsRoute extends GoRouteData {
  const TermsRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const TermsView(),
    );
  }
}

class PrivacyRoute extends GoRouteData {
  const PrivacyRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const PrivacyView(),
    );
  }
}

class FaqRoute extends GoRouteData {
  const FaqRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const FaqViewModal(),
    );
  }
}

class SymptomScoresRoute extends GoRouteData {
  const SymptomScoresRoute();

  static final $parentNavigatorKey = SymptomShellRouteData.$navigatorKey;

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

  static final $parentNavigatorKey = SymptomShellRouteData.$navigatorKey;

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

  static final $parentNavigatorKey = SymptomShellRouteData.$navigatorKey;

  final SymptomResultRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: SymptomResultView(score: $extra!.score),
    );
  }
}

class SymptomShellRouteData extends ShellRouteData {
  static final $navigatorKey = GlobalKey<NavigatorState>();

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state, Widget navigator) {
    return ModalBottomSheetPage(
      key: state.pageKey,
      child: SymptomView(
        navigator: navigator,
      ),
    );
  }
}

class GuideTourRoute extends GoRouteData {
  const GuideTourRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage<void>(
      key: state.pageKey,
      barrierDismissible: false,
      barrierColor: const Color(0xFF4F4F4F).withValues(alpha: 0.6),
      child: const GuideTourView(),
    );
  }
}
