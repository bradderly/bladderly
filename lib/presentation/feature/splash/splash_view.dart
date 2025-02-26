import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
