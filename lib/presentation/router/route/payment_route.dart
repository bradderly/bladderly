import 'dart:async';

import 'package:bladderly/domain/model/plan.dart';
import 'package:bladderly/presentation/feature/payment/paywall/paywall_builder.dart';
import 'package:bladderly/presentation/feature/payment/plan/plan_builder.dart';
import 'package:bladderly/presentation/feature/payment/plan_cancel/plan_cancel_builder.dart';
import 'package:bladderly/presentation/feature/payment/promo_code/promo_code_builder.dart';
import 'package:bladderly/presentation/router/page/modal_bottom_sheet_page.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class PlanRoute extends GoRouteData {
  const PlanRoute();

  static final $parentNavigatorKey = PaymentShellRoute.$navigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlanBuilder();
  }
}

class PlanCancelRoute extends GoRouteData {
  const PlanCancelRoute();

  static final $parentNavigatorKey = PaymentShellRoute.$navigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const PlanCancelBuilder(),
    );
  }
}

class PromoCodeRoute extends GoRouteData {
  const PromoCodeRoute();

  static final $parentNavigatorKey = PaymentShellRoute.$navigatorKey;
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      child: const PromoCodeBuilder(),
    );
  }
}

class PaymentShellRoute extends ShellRouteData {
  static final $navigatorKey = GlobalKey<NavigatorState>();

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state, Widget navigator) {
    return ModalBottomSheetPage<void>(
      key: state.pageKey,
      builder: (context) => navigator,
    );
  }
}

class PaywallRouteExtra extends Equatable {
  const PaywallRouteExtra({
    required this.plans,
  });

  final List<Plan> plans;

  @override
  List<Object> get props => [
        plans,
      ];
}

class PaywallRoute extends GoRouteData {
  const PaywallRoute({
    required this.$extra,
  });

  final PaywallRouteExtra? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoPage<void>(
        key: state.pageKey,
        child: PaywallBuilder(plans: $extra!.plans),
      );

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if ($extra == null) {
      return const MenuRoute().location;
    }

    return super.redirect(context, state);
  }
}
