// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/presentation/feature/menu/menu_builder.dart';
import 'package:bladderly/presentation/feature/menu/plan/plan_main_modal.dart';
import 'package:bladderly/presentation/feature/menu/profile/user_profile_modal.dart';
import 'package:bladderly/presentation/feature/menu/symptom/symptom_modal.dart';

class MenuRoute extends GoRouteData {
  const MenuRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: const MenuBuilder(),
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
