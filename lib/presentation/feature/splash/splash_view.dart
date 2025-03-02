// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
import 'package:bladderly/presentation/router/route/intro_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future<void>.delayed(
        const Duration(seconds: 1),
        () {
          if (!mounted) return;

          if (context.read<UserBloc>().state is UserLoadSuccess) {
            return const MainRoute().go(context);
          }

          return const IntroRoute().go(context);
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Assets.img.imgOnboardingBg.image(fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Assets.icon.icOnboardingLogo.svg(),
            ),
          ),
        ),
      ],
    );
  }
}
