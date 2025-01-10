import 'package:bradderly/presentation/feature/main/main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part 'main_route.g.dart';

@TypedGoRoute<MainRoute>(
  name: 'main',
  path: '/',
  routes: [],
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
