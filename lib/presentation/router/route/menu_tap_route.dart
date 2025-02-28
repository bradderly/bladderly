import 'package:bladderly/presentation/feature/menu/model/menu_view.dart';
import 'package:bladderly/presentation/feature/menu/plan/plan_main_modal.dart';
import 'package:bladderly/presentation/feature/menu/profile/user_profile_modal.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

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

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const UserProfileModal(),
    );
  }
}

class PlanRoute extends GoRouteData {
  const PlanRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const PlanMainModal(),
    );
  }
}

class SymptomRoute extends GoRouteData {
  const SymptomRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const SymptomModal(),
    );
  }
}
