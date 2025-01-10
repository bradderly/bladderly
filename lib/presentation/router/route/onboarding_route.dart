// Flutter imports:
import 'package:bradderly/presentation/feature/onboarding/onboarding_view.dart';
import 'package:bradderly/presentation/feature/signin/signin_view.dart';
import 'package:bradderly/presentation/feature/signup/signup_view.dart';
import 'package:bradderly/presentation/feature/welcome/welcom_view.dart';
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
part 'onboarding_route.g.dart';

@TypedGoRoute<OnboardingRoute>(
  name: 'onboarding',
  path: '/onboarding',
  routes: [
    TypedGoRoute<SigninRoute>(name: 'signin', path: 'signin'),
    TypedGoRoute<SignupRoute>(name: 'signup', path: 'signup'),
    TypedGoRoute<WelcomeRoute>(name: 'welcome', path: 'welcome'),
  ],
)
class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const OnboardingView(),
      );
}

class SigninRoute extends GoRouteData {
  const SigninRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const SigninView(),
      );
}

class SignupRoute extends GoRouteData {
  const SignupRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const SignupView(),
      );
}

class WelcomeRoute extends GoRouteData {
  const WelcomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const WelcomView(),
      );
}
