// Flutter imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/domain/model/history.dart';
import 'package:bladderly/presentation/common/model/beverage_type_model.dart';
import 'package:bladderly/presentation/feature/diary/detailed_list/detailed_list_builder.dart';
import 'package:bladderly/presentation/feature/export/export_builder.dart';
import 'package:bladderly/presentation/feature/input/intake_input/intake_input_builder.dart';
import 'package:bladderly/presentation/feature/input/manual_input/manual_input_builder.dart';
import 'package:bladderly/presentation/feature/input/sound_input_note/sound_input_note_builder.dart';
import 'package:bladderly/presentation/feature/input/sound_input_recording/sound_input_recording_builder.dart';
import 'package:bladderly/presentation/feature/main/main_builder.dart';
import 'package:bladderly/presentation/feature/menu/menu_builder.dart';
import 'package:bladderly/presentation/feature/menu/plan/paywall/paywall_builder.dart';
import 'package:bladderly/presentation/feature/sign_up/regular/sign_up_regular_builder.dart';
import 'package:bladderly/presentation/feature/tutorial/how_to_use/how_to_use_view.dart';

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
    TypedGoRoute<ExportRoute>(
      name: 'export',
      path: 'export',
    ),
    TypedGoRoute<MenuRoute>(
      path: 'menu',
      name: 'menu',
      routes: [
        TypedGoRoute<SignUpRegularRoute>(path: 'sign-up', name: 'sign-up-regular'),
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
    TypedGoRoute<PaywallRoute>(
      name: 'paywall',
      path: 'paywall',
    ),
    TypedGoRoute<HowToUseRoute>(
      name: 'how-to-use',
      path: 'how-to-use',
    ),
  ],
)
class MainRoute extends GoRouteData {
  const MainRoute({
    this.tab,
  });

  final MainRouteTab? tab;

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
    this.historyId,
  });

  final int? historyId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: ManualInputBuilder(
        historyId: historyId,
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
    required this.historyId,
  });

  const IntakeInputRoute.fromBeverageType({
    required BeverageTypeModel beverageType,
  }) : this(beverageType: beverageType, historyId: null);

  const IntakeInputRoute.fromHistoryId({
    required int historyId,
  }) : this(beverageType: null, historyId: historyId);

  final BeverageTypeModel? beverageType;
  final int? historyId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: IntakeInputBuilder(
        beverageTypeModel: beverageType,
        historyId: historyId,
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

class PaywallRoute extends GoRouteData {
  const PaywallRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const PaywallBuilder(),
      );
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
