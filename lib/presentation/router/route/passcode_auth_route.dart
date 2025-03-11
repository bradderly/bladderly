import 'package:bladderly/presentation/feature/passcode/auth/passcode_auth_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part 'passcode_auth_route.g.dart';

@TypedGoRoute<PasscodeAuthRoute>(
  name: 'passcode-auth',
  path: '/passcode-auth',
)
class PasscodeAuthRoute extends GoRouteData {
  const PasscodeAuthRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      canPop: false,
      child: const PasscodeAuthBuilder(),
    );
  }
}
