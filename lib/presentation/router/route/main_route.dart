import 'package:bradderly/core/recorder/src/recorder_file.dart';
import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/presentation/common/model/beverage_type_model.dart';
import 'package:bradderly/presentation/feature/diary/detailed_list/detailed_list_builder.dart';
import 'package:bradderly/presentation/feature/export/export_builder.dart';
import 'package:bradderly/presentation/feature/input/intake_input/intake_input_builder.dart';
import 'package:bradderly/presentation/feature/input/manual_input/manual_input_builder.dart';
import 'package:bradderly/presentation/feature/input/sound_input_note/sound_input_note_builder.dart';
import 'package:bradderly/presentation/feature/input/sound_input_recording/sound_input_recording_builder.dart';
import 'package:bradderly/presentation/feature/main/main_builder.dart';
import 'package:bradderly/presentation/feature/menu/model/menu_view.dart';
import 'package:bradderly/presentation/feature/menu/plan/paywall_view.dart';
import 'package:equatable/equatable.dart';
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
    TypedGoRoute<ExportRoute>(
      name: 'export',
      path: 'export',
    ),
    TypedGoRoute<MenuRoute>(
      name: 'menu',
      path: 'menu',
    ),
    TypedGoRoute<SoundInputRecordingRoute>(
      name: 'sound_input_recording',
      path: 'sound_input_recording',
    ),
    TypedGoRoute<SoundInputNoteRoute>(
      name: 'sound_input_note',
      path: 'sound_input_note',
    ),
    TypedGoRoute<ManualInputRoute>(
      name: 'manual_input',
      path: 'manual_input',
    ),
    TypedGoRoute<IntakeInputRoute>(
      name: 'intake_input',
      path: 'intake_input',
    ),
    TypedGoRoute<DetailedListRoute>(
      name: 'detailed_list',
      path: 'detailed_list',
    ),
    TypedGoRoute<PaywallRoute>(
      name: 'paywall',
      path: 'paywall',
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

class MenuRoute extends GoRouteData {
  const MenuRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: const MenuView(),
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
    this.$extra,
  });

  final SoundInputNoteRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: SoundInputNoteBuilder(
        recorderFile: $extra!.file,
      ),
    );
  }
}

class SoundInputNoteRouteExtra extends Equatable {
  const SoundInputNoteRouteExtra({
    required this.file,
  });

  final RecorderFile file;

  @override
  List<Object> get props => [
        file.name,
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
        child: const PaywallView(),
      );
}
