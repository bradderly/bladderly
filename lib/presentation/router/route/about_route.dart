import 'package:bladderly/presentation/feature/about/about_view.dart';
import 'package:bladderly/presentation/feature/about/privacy/privacy_view.dart';
import 'package:bladderly/presentation/feature/about/terms/terms_view.dart';
import 'package:bladderly/presentation/router/page/modal_bottom_sheet_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AboutRoute extends GoRouteData {
  const AboutRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ModalBottomSheetPage<void>(
      key: state.pageKey,
      builder: (_) => const AboutView(),
    );
  }
}

class TermsRoute extends GoRouteData {
  const TermsRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: const TermsView(),
    );
  }
}

class PrivacyRoute extends GoRouteData {
  const PrivacyRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      child: const PrivacyView(),
    );
  }
}
