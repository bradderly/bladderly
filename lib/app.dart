import 'package:bradderly/presentation/common/bloc/user_bloc.dart';
import 'package:bradderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bradderly/presentation/common/cubit/unit_cubit.dart';
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/locale/app_locale.dart';
import 'package:bradderly/presentation/router/app_router.dart';
import 'package:bradderly/presentation/theme/color/color_theme.dart';
import 'package:bradderly/presentation/theme/shadow/shadow_theme.dart';
import 'package:bradderly/presentation/theme/text_style/text_style_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

class _ScrollBehavior extends ScrollBehavior {
  const _ScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
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
  final appLocaleCubit = AppLocaleCubit();

  @override
  void initState() {
    FlutterLocalization.instance.init(
      initLanguageCode: appLocaleCubit.state.name,
      mapLocales: AppLocale.values.map((e) => MapLocale(e.name, {})).toList(),
    );
    super.initState();
  }

  @override
  void dispose() {
    appLocaleCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UnitCubit>(
          create: (_) => UnitCubit(),
        ),
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(),
        ),
        BlocProvider<AppLocaleCubit>.value(
          value: appLocaleCubit,
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
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: context.colorTheme.neutral.shade7,
              ),
            ),
            child: ScrollConfiguration(
              behavior: const _ScrollBehavior(),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: child,
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
