import 'package:bradderly/presentation/feature/main/cubit/main_tab_cubit.dart';
import 'package:bradderly/presentation/feature/main/diary/cubit/diary_cubit.dart';
import 'package:bradderly/presentation/feature/main/diary/cubit/diary_history_dates_cubit.dart';
import 'package:bradderly/presentation/feature/main/diary/widget/dairy_histories_widget.dart';
import 'package:bradderly/presentation/feature/main/diary/widget/diary_app_bar.dart';
import 'package:bradderly/presentation/feature/main/diary/widget/diary_today_summary_widget.dart';
import 'package:bradderly/presentation/router/route/main_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({
    super.key,
  });

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  final voidingSummaryKey = GlobalKey();
  final voidingSummaryExpandController = ValueNotifier(false);
  final intakeSummaryKey = GlobalKey();
  final intakeSummaryExpandController = ValueNotifier(false);

  DateTime today = DateUtils.dateOnly(DateTime.now());

  @override
  void dispose() {
    scrollController.dispose();
    voidingSummaryExpandController.dispose();
    intakeSummaryExpandController.dispose();
    super.dispose();
  }

  void scrollToSection(MainTabDiaryScrollScetion scrollSection) {
    final key = switch (scrollSection) {
      MainTabDiaryScrollScetion.voiding => voidingSummaryKey,
      MainTabDiaryScrollScetion.intake => intakeSummaryKey,
      _ => null,
    };

    final notifier = switch (scrollSection) {
      MainTabDiaryScrollScetion.voiding => voidingSummaryExpandController,
      MainTabDiaryScrollScetion.intake => intakeSummaryExpandController,
      _ => null,
    };

    if (key?.currentContext case final BuildContext context) {
      notifier?.value = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) Scrollable.ensureVisible(context);
      });
    }
  }

  void onDateChanged(DateTime dateTime) {
    context.read<DiaryCubit>().subscribe(dateTime);
    voidingSummaryExpandController.value = false;
    intakeSummaryExpandController.value = false;
    scrollController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<MainTabCubit, MainTabState>(
      listenWhen: (_, curr) => curr is MainTabDiary,
      listener: (_, __) => scrollToSection((context.read<MainTabCubit>().state as MainTabDiary).scrollSection),
      child: ScrollsToTop(
        onScrollsToTop: (_) => scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCirc,
        ),
        child: Scaffold(
          appBar: DiaryAppBar(
            onTapExport: () =>
                ExportRoute(historyDates: context.read<DiaryHistoryDatesCubit>().state.dates).push<void>(context),
            onChanged: onDateChanged,
            today: DateUtils.dateOnly(DateTime.now()),
          ),
          body: SafeArea(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 61),
              children: [
                BlocBuilder<DiaryCubit, DiaryState>(
                  buildWhen: (prev, curr) =>
                      prev.diaryIntakeSummaryModel != curr.diaryIntakeSummaryModel ||
                      prev.diaryVoidingSummaryModel != curr.diaryVoidingSummaryModel,
                  builder: (context, state) => DiaryTodaySummaryWidget(
                    voidingSummaryKey: voidingSummaryKey,
                    voidingSummaryExpandController: voidingSummaryExpandController,
                    diaryVoidingSummaryModel: state.diaryVoidingSummaryModel,
                    intakeSummaryKey: intakeSummaryKey,
                    intakeSummaryExpandController: intakeSummaryExpandController,
                    diaryIntakeSummaryModel: state.diaryIntakeSummaryModel,
                  ),
                ),
                const Gap(37),
                BlocBuilder<DiaryCubit, DiaryState>(
                  buildWhen: (prev, curr) => !listEquals(prev.diaryHistoryModels, curr.diaryHistoryModels),
                  builder: (context, state) => DiaryHistoriesWidget(
                    diaryHistoryModels: state.diaryHistoryModels,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
