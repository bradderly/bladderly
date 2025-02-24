// Flutter imports:
import 'package:bradderly/presentation/feature/intro/intro_view.dart';
import 'package:bradderly/presentation/feature/signin/singin_builder.dart';
import 'package:bradderly/presentation/feature/signup/guest/signup_guest_builder.dart';
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
part 'intro_route.g.dart';

@TypedGoRoute<IntroRoute>(
  name: 'intro',
  path: '/intro',
  routes: [
    TypedGoRoute<SigninRoute>(name: 'signin', path: 'signin'),
    TypedGoRoute<SignupGuestRoute>(name: 'signup', path: 'signup'),
  ],
)
class IntroRoute extends GoRouteData {
  const IntroRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const IntroView(),
      );
}

class SigninRoute extends GoRouteData {
  const SigninRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const SinginBuilder(),
      );
}

class SignupGuestRoute extends GoRouteData {
  const SignupGuestRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const SignupGuestBuilder(),
      );
}
