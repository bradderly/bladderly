// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/check_supported_device_usecase.dart';
import 'package:bladderly/domain/usecase/get_history_result_usecase.dart';
import 'package:bladderly/domain/usecase/get_membership_stream_usecase.dart';
import 'package:bladderly/domain/usecase/get_user_stream_usecase.dart';
import 'package:bladderly/domain/usecase/get_user_usecase.dart';
import 'package:bladderly/domain/usecase/initialize_membership_usecase.dart';
import 'package:bladderly/domain/usecase/initialize_purchase_handler_usecase.dart';
import 'package:bladderly/domain/usecase/load_app_config_usecase.dart';
import 'package:bladderly/domain/usecase/purchase_plan_usecase.dart';
import 'package:bladderly/domain/usecase/refresh_history_result_usecase.dart';
import 'package:bladderly/domain/usecase/sign_out_usecase.dart';
import 'package:bladderly/presentation/common/bloc/app_config_bloc.dart';
import 'package:bladderly/presentation/common/bloc/device_bloc.dart';
import 'package:bladderly/presentation/common/bloc/history_result_bloc.dart';
import 'package:bladderly/presentation/common/bloc/membership_bloc.dart';
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bladderly/presentation/common/cubit/main_tab_cubit.dart';
import 'package:bladderly/presentation/common/cubit/passcode_cubit.dart';
import 'package:bladderly/presentation/common/cubit/unit_cubit.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/widget/no_over_bouncing_scroll_physcis.dart';
import 'package:bladderly/presentation/feature/payment/bloc/payment_bloc.dart';
import 'package:bladderly/presentation/router/app_router.dart';
import 'package:bladderly/presentation/theme/color/color_theme.dart';
import 'package:bladderly/presentation/theme/shadow/shadow_theme.dart';
import 'package:bladderly/presentation/theme/text_style/text_style_theme.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

class _ScrollBehavior extends ScrollBehavior {
  const _ScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const NoOverBouncingScrollPhysics();
  }

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class BladderlyApp extends StatefulWidget {
  const BladderlyApp({super.key});

  @override
  State<BladderlyApp> createState() => _BladderlyAppState();
}

class _BladderlyAppState extends State<BladderlyApp> {
  @override
  void initState() {
    super.initState();

    FlutterLocalization.instance.init(
      initLanguageCode: AppLocaleCubit().state.name,
      mapLocales: AppLocale.values.map((e) => MapLocale(e.name, {})).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UnitCubit>(
          create: (_) => UnitCubit(),
        ),
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(
            getUserUsecase: getIt<GetUserUsecase>(),
            getUserStreamUsecase: getIt<GetUserStreamUsecase>(),
            signOutUsecase: getIt<SignOutUsecase>(),
          )..add(const UserLoad()),
        ),
        BlocProvider<AppLocaleCubit>(
          create: (_) => AppLocaleCubit(),
        ),
        BlocProvider<HistoryResultBloc>(
          create: (_) => HistoryResultBloc(
            getHistoryProcessingResultUsecase: getIt<GetHistoryResultUsecase>(),
            refreshHistoryResultUsecase: getIt<RefreshHistoryResultUsecase>(),
          ),
        ),
        BlocProvider<PasscodeCubit>(create: (_) => PasscodeCubit()),
        BlocProvider<AppConfigBloc>(
          create: (_) => AppConfigBloc(
            loadAppConfigUsecase: getIt<LoadAppConfigUsecase>(),
          ),
        ),
        BlocProvider<PaymentBloc>(
          create: (_) => PaymentBloc(
            initializePurchaseHandlerUsecase: getIt<InitializePurchaseHandlerUsecase>(),
            purchasePlanUsecase: getIt<PurchasePlanUsecase>(),
          ),
        ),
        BlocProvider<DeviceBloc>(
          create: (_) => DeviceBloc(
            checkSupportedDeviceUsecase: getIt<CheckSupportedDeviceUsecase>(),
          ),
        ),
        BlocProvider<MembershipBloc>(
          create: (_) => MembershipBloc(
            getMembershipStreamUsecase: getIt<GetMembershipStreamUsecase>(),
            initializeMembershipUsecase: getIt<InitializeMembershipUsecase>(),
          ),
        ),
        BlocProvider<MainTabCubit>(
          create: (_) => MainTabCubit(),
        ),
      ],
      child: BlocListener<AppLocaleCubit, AppLocale>(
        listener: (context, state) => FlutterLocalization.instance.translate(state.name),
        child: MaterialApp.router(
          routeInformationParser: AppRouter.goRouter.routeInformationParser,
          routerDelegate: AppRouter.goRouter.routerDelegate,
          routeInformationProvider: AppRouter.goRouter.routeInformationProvider,
          supportedLocales: FlutterLocalization.instance.supportedLocales,
          localizationsDelegates: FlutterLocalization.instance.localizationsDelegates,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: Theme(
              data: Theme.of(context).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: context.colorTheme.neutral.shade7,
                ),
              ),
              child: ScrollConfiguration(
                behavior: const _ScrollBehavior(),
                child: GestureDetector(
                  onTap: FocusScope.of(context).unfocus,
                  child: child,
                ),
              ),
            ),
          ),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
            ),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            extensions: <ThemeExtension>[
              BladderlyColorTheme(),
              BladderlyTextStyleTheme(),
              BladderlyShadowTheme(),
            ],
          ),
        ),
      ),
    );
  }
}
