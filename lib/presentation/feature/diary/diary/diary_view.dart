import 'package:bladderly/presentation/feature/diary/diary/cubit/diary_cubit.dart';
import 'package:bladderly/presentation/feature/diary/diary/cubit/diary_history_dates_cubit.dart';
import 'package:bladderly/presentation/feature/diary/diary/model/diary_tab_scroll_section_model.dart';
import 'package:bladderly/presentation/feature/diary/diary/widget/dairy_histories_widget.dart';
import 'package:bladderly/presentation/feature/diary/diary/widget/diary_app_bar.dart';
import 'package:bladderly/presentation/feature/diary/diary/widget/diary_today_summary_widget.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({
    super.key,
    required this.diaryTabScrollSectionModel,
  });

  final DiaryTabScrollSectionModel? diaryTabScrollSectionModel;

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  final voidingSummaryKey = GlobalKey();
  final voidingSummaryExpandController = ValueNotifier(false);
  final intakeSummaryKey = GlobalKey();
  final intakeSummaryExpandController = ValueNotifier(false);

  final today = DateUtils.dateOnly(DateTime.now());

  @override
  void initState() {
    super.initState();

    if (widget.diaryTabScrollSectionModel case final DiaryTabScrollSectionModel diaryTabScrollSectionModel) {
      scrollToSection(diaryTabScrollSectionModel);
    }
  }

  @override
  void didUpdateWidget(covariant DiaryView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.diaryTabScrollSectionModel case final DiaryTabScrollSectionModel diaryTabScrollSectionModel
        when widget.diaryTabScrollSectionModel != oldWidget.diaryTabScrollSectionModel) {
      scrollToSection(diaryTabScrollSectionModel);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    voidingSummaryExpandController.dispose();
    intakeSummaryExpandController.dispose();
    super.dispose();
  }

  void scrollToSection(DiaryTabScrollSectionModel scrollSection) {
    final key = switch (scrollSection) {
      DiaryTabScrollSectionModel.voiding => voidingSummaryKey,
      DiaryTabScrollSectionModel.intake => intakeSummaryKey,
      _ => null,
    };

    final notifier = switch (scrollSection) {
      DiaryTabScrollSectionModel.voiding => voidingSummaryExpandController,
      DiaryTabScrollSectionModel.intake => intakeSummaryExpandController,
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

    return ScrollsToTop(
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
          today: today,
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
                builder: (context, state) => DiaryHistoriesWidget(
                  onTapHistory: (id) => DetailedListRoute(historyId: id, date: state.dateTime).go(context),
                  diaryHistoryModels: state.diaryHistoryModels,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
