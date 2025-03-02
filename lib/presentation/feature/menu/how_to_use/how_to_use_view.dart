// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bladderly/presentation/feature/menu/how_to_use/widget/howtouse_page_view.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';

class HowtouseView extends StatefulWidget {
  const HowtouseView({super.key});

  @override
  State<HowtouseView> createState() => _HowtouseViewState();
}

class _HowtouseViewState extends State<HowtouseView> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        title: Row(
          children: [
            Assets.icon.icHowToUseLogo.svg(),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => context.pop<bool>(true),
            child: Text(
              'Skip ->',
              style: context.textStyleTheme.b16SemiBold.copyWith(
                color: context.colorTheme.vermilion.primary.shade50,
              ),
            ),
          ),
          const Gap(20),
        ],
      ),
      body: SafeArea(
        child: HowToUsePageView(
          pageController: pageController,
          gender: context.read<UserBloc>().state.userModelOrThrowException.gender,
        ),
      ),
    );
  }
}
