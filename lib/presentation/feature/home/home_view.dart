import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/common/widget/primary_background.dart';
import 'package:bradderly/presentation/feature/home/cubit/home_summary_cubit.dart';
import 'package:bradderly/presentation/feature/home/model/home_intake_summary_model.dart';
import 'package:bradderly/presentation/feature/home/model/home_voiding_summary_model.dart';
import 'package:bradderly/presentation/feature/home/widget/home_app_bar.dart';
import 'package:bradderly/presentation/feature/home/widget/home_intake_widget.dart';
import 'package:bradderly/presentation/feature/home/widget/home_voiding_widget.dart';
import 'package:bradderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        const PrimaryBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            fit: StackFit.expand,
            children: [
              SafeArea(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    Gap(HomeAppBar.height),
                    Text(
                      'Today Summary'.tr,
                      style: context.textStyleTheme.b24BoldOutfit.copyWith(color: context.colorTheme.neutral.shade0),
                    ),
                    const Gap(16),
                    BlocSelector<HomeSummaryCubit, HomeSummaryState, HomeVoidingSummaryModel>(
                      selector: (state) => state.voidingSummaryModel,
                      builder: (context, homeVoidingSummaryModel) => HomeVoidingWidget(
                        homeVoidingSummaryModel: homeVoidingSummaryModel,
                      ),
                    ),
                    const Gap(40),
                    BlocSelector<HomeSummaryCubit, HomeSummaryState, HomeIntakeSummaryModel>(
                      selector: (state) => state.intakeSummaryModel,
                      builder: (context, intakeSummaryModel) => HomeIntakeWidget(
                        homeIntakeSummaryModel: intakeSummaryModel,
                      ),
                    ),
                    const Gap(53),
                  ],
                ),
              ),
              Positioned.fill(
                bottom: null,
                child: HomeAppBar(
                  onTapMenu: () => const MenuRoute().go(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
