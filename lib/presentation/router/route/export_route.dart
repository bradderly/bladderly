import 'dart:async';

import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/presentation/feature/export/calendar/export_calendar_builder.dart';
import 'package:bladderly/presentation/feature/export/export_view.dart';
import 'package:bladderly/presentation/feature/export/paywall/export_paywall_view.dart';
import 'package:bladderly/presentation/feature/export/report/export_report_builder.dart';
import 'package:bladderly/presentation/router/page/modal_bottom_sheet_page.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class ExportShellRoute extends ShellRouteData {
  const ExportShellRoute();

  static final $navigatorKey = GlobalKey<NavigatorState>();

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state, Widget navigator) {
    return ModalBottomSheetPage(
      key: state.pageKey,
      useSafeArea: true,
      child: ExportView(navigator: navigator),
    );
  }
}

class ExportPayWallRouteExtra extends Equatable {
  const ExportPayWallRouteExtra({
    required this.plan,
  });
  final Plan plan;

  @override
  List<Object?> get props => [
        plan,
      ];
}

class ExportPayWallRoute extends GoRouteData {
  const ExportPayWallRoute({
    this.$extra,
  });

  final ExportPayWallRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: ExportPaywallView(
        plan: $extra!.plan,
      ),
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if ($extra == null) return const ExportCalendarRoute().location;

    return super.redirect(context, state);
  }
}

class ExportCalendarRoute extends GoRouteData {
  const ExportCalendarRoute();

  static final $parentNavigatorKey = ExportShellRoute.$navigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage<void>(
      child: ExportCalendarBuilder(),
    );
  }
}

class ExportReportRouteExtra extends Equatable {
  const ExportReportRouteExtra({
    required this.selectedDates,
  });

  final List<DateTime> selectedDates;

  @override
  List<Object> get props => [selectedDates];
}

class ExportReportRoute extends GoRouteData {
  const ExportReportRoute({
    this.$extra,
  });

  final ExportReportRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      child: ExportReportBuilder(
        selectedDates: $extra?.selectedDates ?? [],
      ),
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if ($extra == null) return const ExportCalendarRoute().location;

    return super.redirect(context, state);
  }
}
