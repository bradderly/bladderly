// Flutter imports:
import 'dart:async';

import 'package:bladderly/presentation/feature/intro/intro_view.dart';
import 'package:bladderly/presentation/feature/sign_in/sing_in_builder.dart';
import 'package:bladderly/presentation/feature/sign_up/guest/sign_up_guest_builder.dart';
import 'package:bladderly/presentation/feature/sign_up/social/sign_up_social_builder.dart';
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
    TypedGoRoute<SignInRoute>(
      name: 'sign-in',
      path: 'sign-in',
      routes: [
        TypedGoRoute<SignUpSocialRoute>(name: 'sign-up-social', path: 'sign-up-social'),
      ],
    ),
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

class SignUpGuestRoute extends GoRouteData {
  const SignUpGuestRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const SignUpGuestBuilder(),
      );
}

class SignUpSocialRouteExtra extends Equatable {
  const SignUpSocialRouteExtra({
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

class SignUpSocialRoute extends GoRouteData {
  const SignUpSocialRoute({
    this.$extra,
  });

  final SignUpSocialRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: SignUpSocialBuilder(
        email: $extra!.email,
        signUpMethod: $extra!.signUpMethod,
      ),
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if ($extra == null) {
      return const IntroRoute().location;
    }

    return null;
  }
}
