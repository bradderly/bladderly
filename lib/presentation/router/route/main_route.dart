import 'package:bradderly/presentation/feature/main/main_view.dart';
import 'package:bradderly/presentation/feature/menu/model/menu_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part 'main_route.g.dart';

@TypedGoRoute<MainRoute>(
  name: 'main',
  path: '/',
  routes: [
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
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const MainView(),
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
