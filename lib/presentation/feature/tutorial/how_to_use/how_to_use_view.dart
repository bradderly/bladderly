// Flutter imports:

// Project imports:
import 'package:bladderly/presentation/common/bloc/user_bloc.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/feature/tutorial/how_to_use/widget/howtouse_page_view.dart';
import 'package:bladderly/presentation/generated/assets/assets.gen.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
          ListenableBuilder(
            listenable: pageController,
            builder: (context, child) => pageController.page?.round() == 5 ? const SizedBox.shrink() : child!,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => context.pop<bool>(true),
              child: Text(
                'Skip ->',
                style: context.textStyleTheme.b16SemiBold.copyWith(
                  color: context.colorTheme.vermilion.primary.shade50,
                ),
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
