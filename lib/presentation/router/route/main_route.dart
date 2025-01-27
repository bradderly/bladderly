import 'package:bradderly/presentation/feature/export/export_builder.dart';
import 'package:bradderly/presentation/feature/main/main_builder.dart';
import 'package:bradderly/presentation/feature/menu/model/menu_view.dart';
import 'package:cupertino_modal_sheet/cupertino_modal_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part 'main_route.g.dart';

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
  ],
)
class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoModalSheetPage<void>(
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
    return CupertinoModalSheetPage<void>(
      key: state.pageKey,
      child: ExportBuilder(historyDates: historyDates),
    );
  }
}
