// Flutter imports:
// Project imports:
import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:bladderly/presentation/common/bloc/membership_bloc.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/widget/progress_indicator_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PlanCancelView extends StatefulWidget {
  const PlanCancelView._();

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      useRootNavigator: false,
      builder: (_) => const PlanCancelView._(),
    );
  }

  @override
  State<PlanCancelView> createState() => _PlanCancelViewState();
}

class _PlanCancelViewState extends State<PlanCancelView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
      ..addObserver(this)
      ..addPostFrameCallback((_) => initialize());
  }

  @override
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> initialize() async {
    unawaited(ProgressIndicatorModal.show(context, useRootNavigator: false));

    if (Platform.isIOS) return AppSettings.openAppSettings(type: AppSettingsType.subscriptions);

    if (Platform.isAndroid) {
      return launchUrlString('https://play.google.com/store/account/subscriptions')
          .then((_) => null)
          .catchError((e) => null);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final userId = context.read<UserBloc>().state.userModelOrThrowException.id;

      context.read<MembershipBloc>().add(MembershipInitialize(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MembershipBloc, MembershipState>(
      listener: (context, state) => switch (state) {
        MembershipInitializeSuccess() || MembershipInitializeFailure() when context.mounted => context.pop(),
        _ => null
      },
      child: const SizedBox.shrink(),
    );
  }
}
