// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/splash_route.dart';

// Project imports:

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final goRouter = GoRouter(
    initialLocation: const SplashRoute().location,
    navigatorKey: navigatorKey,
    routes: [
      $introRoute,
      $mainRoute,
      $splashRoute,
    ],
  );
}
