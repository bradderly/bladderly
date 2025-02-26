// Flutter imports:
import 'package:bradderly/presentation/feature/splash/splash_builder.dart';
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
part 'splash_route.g.dart';

@TypedGoRoute<SplashRoute>(
  name: 'splash',
  path: '/splash',
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const SplashBuilder(),
      );
}
