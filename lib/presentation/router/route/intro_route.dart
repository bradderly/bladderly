// Flutter imports:
import 'package:bladderly/presentation/feature/intro/intro_view.dart';
import 'package:bladderly/presentation/feature/sign_in/sing_in_builder.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/sign_up_guest_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
part 'intro_route.g.dart';

@TypedGoRoute<IntroRoute>(
  name: 'intro',
  path: '/intro',
  routes: [
    TypedGoRoute<SignInRoute>(name: 'sign-in', path: 'sign-in'),
    TypedGoRoute<SignUpGuestRoute>(name: 'sign-up', path: 'sign-up'),
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

class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const SinginBuilder(),
      );
}

class SignUpGuestRouteExtra extends Equatable {
  const SignUpGuestRouteExtra({
    required this.email,
    required this.signUpMethod,
  });

  final String email;
  final String signUpMethod;

  @override
  List<Object> get props => [
        email,
        signUpMethod,
      ];
}

class SignUpGuestRoute extends GoRouteData {
  const SignUpGuestRoute({
    this.$extra,
  });

  final SignUpGuestRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: SignUpGuestBuilder(
          email: $extra?.email,
          signUpMethod: $extra?.signUpMethod,
        ),
      );
}
