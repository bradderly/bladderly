// Flutter imports:

// Project imports:
import 'dart:async';

import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/detailed_list_builder.dart';
import 'package:bladderly/presentation/feature/input/intake_input/intake_input_builder.dart';
import 'package:bladderly/presentation/feature/input/manual_input/manual_input_builder.dart';
import 'package:bladderly/presentation/feature/input/sound_input_note/sound_input_note_builder.dart';
import 'package:bladderly/presentation/feature/input/sound_input_recording/sound_input_recording_builder.dart';
import 'package:bladderly/presentation/feature/main/main_builder.dart';
import 'package:bladderly/presentation/feature/menu/faq/faq_view_modal.dart';
import 'package:bladderly/presentation/feature/menu/menu_builder.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/sign_up_regular_builder.dart';
import 'package:bladderly/presentation/feature/tutorial/guide_tour/guide_tour_view.dart';
import 'package:bladderly/presentation/feature/tutorial/how_to_use/how_to_use_view.dart';
import 'package:bladderly/presentation/router/page/dialog_page.dart';
import 'package:bladderly/presentation/router/route/about_route.dart';
import 'package:bladderly/presentation/router/route/export_route.dart';
import 'package:bladderly/presentation/router/route/payment_route.dart';
import 'package:bladderly/presentation/router/route/profile_route.dart';
import 'package:bladderly/presentation/router/route/symtom_route.dart';
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
    TypedShellRoute<ExportShellRoute>(
      routes: [
        TypedGoRoute<ExportCalendarRoute>(
          name: 'export-calendar',
          path: 'export-calendar',
          routes: [
            TypedGoRoute<ExportReportRoute>(
              name: 'export-report',
              path: 'export-report',
            ),
          ],
        ),
      ],
    ),
    TypedGoRoute<ExportPayWallRoute>(
      name: 'export-paywall',
      path: 'export-paywall',
    ),
    TypedGoRoute<MenuRoute>(
      path: 'menu',
      name: 'menu',
      routes: [
        TypedGoRoute<SignUpRegularRoute>(path: 'sign-up', name: 'sign-up-regular'),
        TypedGoRoute<AboutRoute>(
          path: 'about',
          name: 'about',
          routes: [
            TypedGoRoute<TermsRoute>(
              path: 'terms',
              name: 'terms',
            ),
            TypedGoRoute<PrivacyRoute>(
              path: 'privacy',
              name: 'privacy',
            ),
          ],
        ),
        TypedGoRoute<FaqRoute>(path: 'faq', name: 'faq'),
        TypedShellRoute<SymptomShellRoute>(
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
        TypedShellRoute<PaymentShellRoute>(
          routes: [
            TypedGoRoute<PlanRoute>(
              path: 'plan',
              name: 'plan',
              routes: [
                TypedGoRoute<PlanCancelRoute>(
                  path: 'plan-cancel',
                  name: 'plan-cancel',
                ),
                TypedGoRoute<PromoCodeRoute>(
                  path: 'promo-code',
                  name: 'promo-code',
                ),
              ],
            ),
          ],
        ),
        TypedGoRoute<PaywallRoute>(
          name: 'paywall',
          path: 'paywall',
        ),
        TypedShellRoute<ProfileShellRoute>(
          routes: [
            TypedGoRoute<ProfileRoute>(
              path: 'profile',
              name: 'profile',
              routes: [
                TypedGoRoute<ChangePasswordRoute>(
                  path: 'change-password',
                  name: 'change-password',
                ),
                TypedGoRoute<PasscodeRoute>(
                  path: 'passcode',
                  name: 'passcode',
                ),
                TypedGoRoute<DeleteAccountRoute>(
                  path: 'delete-account',
                  name: 'delete-account',
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

  static final $navigatorKey = GlobalKey<NavigatorState>();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const MainBuilder(),
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
