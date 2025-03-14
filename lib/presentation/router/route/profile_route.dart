import 'package:bladderly/presentation/feature/passcode/passcode_builder.dart';
import 'package:bladderly/presentation/feature/profile/change_password/change_password_builder.dart';
import 'package:bladderly/presentation/feature/profile/delete_account/delete_account_builder.dart';
import 'package:bladderly/presentation/feature/profile/profile_builder.dart';
import 'package:bladderly/presentation/router/page/modal_bottom_sheet_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordRoute extends GoRouteData {
  const ChangePasswordRoute();

  static final $parentNavigatorKey = ProfileShellRoute.$navigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChangePasswordBuilder();
  }
}

class PasscodeRoute extends GoRouteData {
  const PasscodeRoute();

  static final $parentNavigatorKey = ProfileShellRoute.$navigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PasscodeBuilder();
  }
}

class DeleteAccountRoute extends GoRouteData {
  const DeleteAccountRoute();

  static final $parentNavigatorKey = ProfileShellRoute.$navigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DeleteAccountBuilder();
  }
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  static final $parentNavigatorKey = ProfileShellRoute.$navigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileBuilder();
  }
}

class ProfileShellRoute extends ShellRouteData {
  static final $navigatorKey = GlobalKey<NavigatorState>();

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state, Widget navigator) {
    return ModalBottomSheetPage<void>(
      key: state.pageKey,
      child: navigator,
    );
  }
}
