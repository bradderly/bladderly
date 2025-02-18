/*
import 'package:bradderly/presentation/feature/menu/model/menu_view.dart';
import 'package:bradderly/presentation/feature/menu/plan/plan_view.dart';
import 'package:bradderly/presentation/feature/menu/profile/profile_view.dart';
import 'package:bradderly/presentation/feature/menu/symptom/symptom_view.dart';
import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';

part 'menu_tap_route.g.dart';

@TypedGoRoute<MenuTapRoute>(
  name: 'menutap', path: '/menutap',
  routes: [
    TypedGoRoute<ProfileRoute>(name: 'profile', path: 'profile'),
    TypedGoRoute<PlanRoute>(name: 'plan', path: 'plan'),
    TypedGoRoute<SymptomRoute>(name: 'symptom', path: 'symptom'),
  ],
  )


class MenuTapRoute extends GoRouteData {
  const MenuTapRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const MenuView(),
      );
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child:  ProfileView(),
      );
}

class PlanRoute extends GoRouteData {
  const PlanRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const PlanView(),
      );
}

class SymptomRoute extends GoRouteData {
  const SymptomRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: const SymptomView(),
      );
}


*/
