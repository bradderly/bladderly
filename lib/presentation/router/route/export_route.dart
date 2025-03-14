import 'package:bladderly/presentation/feature/export/calendar/export_calendar_builder.dart';
import 'package:bladderly/presentation/feature/export/export_view.dart';
import 'package:bladderly/presentation/feature/export/paywall/export_paywall_view.dart';
import 'package:bladderly/presentation/feature/export/report/export_report_builder.dart';
import 'package:bladderly/presentation/router/page/modal_bottom_sheet_page.dart';
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

class ExportPageWallRoute extends GoRouteData {
  const ExportPageWallRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: const ExportPaywallView(),
    );
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

class ExportReportRoute extends GoRouteData {
  ExportReportRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage<void>(
      child: ExportReportBuilder(),
    );
  }
}
