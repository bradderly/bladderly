import 'package:bradderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bradderly/presentation/common/cubit/unit_cubit.dart';
import 'package:bradderly/presentation/router/app_router.dart';
import 'package:bradderly/presentation/theme/color/color_theme.dart';
import 'package:bradderly/presentation/theme/shadow/shadow_theme.dart';
import 'package:bradderly/presentation/theme/text_style/text_style_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _ScrollBehavior extends ScrollBehavior {
  const _ScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

class BladderlyApp extends StatelessWidget {
  const BladderlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UnitCubit(),
        ),
        BlocProvider<AppLocaleCubit>(
          create: (_) => AppLocaleCubit(),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: AppRouter.goRouter.routeInformationParser,
        routerDelegate: AppRouter.goRouter.routerDelegate,
        routeInformationProvider: AppRouter.goRouter.routeInformationProvider,
        builder: (_, child) => ScrollConfiguration(behavior: const _ScrollBehavior(), child: child!),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
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
    );
  }
}
