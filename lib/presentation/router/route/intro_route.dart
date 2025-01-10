// Flutter imports:
import 'package:bradderly/presentation/feature/intro/intro_view.dart';
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
part 'intro_route.g.dart';

@TypedGoRoute<IntroRoute>(name: 'intro', path: '/intro')
class IntroRoute extends GoRouteData {
  const IntroRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const IntroView(),
      );
}
