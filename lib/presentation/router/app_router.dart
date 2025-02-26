// Flutter imports:
import 'package:bradderly/presentation/router/route/intro_route.dart';
import 'package:bradderly/presentation/router/route/main_route.dart';
import 'package:bradderly/presentation/router/route/splash_route.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final goRouter = GoRouter(
    initialLocation: const IntroRoute().location,
    navigatorKey: navigatorKey,
    routes: [
      $introRoute,
      $mainRoute,
      $splashRoute,
    ],
  );
}
