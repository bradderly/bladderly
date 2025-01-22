import 'package:bradderly/presentation/feature/diary/diary/cubit/diary_cubit.dart';
import 'package:bradderly/presentation/feature/diary/diary/model/diary_view_scroll_section_model.dart';
import 'package:bradderly/presentation/feature/diary/diary/widget/diary_calendar_widget.dart';
import 'package:bradderly/presentation/feature/diary/diary/widget/diary_today_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({
    super.key,
    required this.scrollSection,
    required this.onApplyScrollSection,
  });

  final DiaryViewScrollSectionModel scrollSection;
  final VoidCallback onApplyScrollSection;

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  final voidingSummaryKey = GlobalKey();
  final voidingSummaryExpandController = ValueNotifier(false);
  final intakeSummaryKey = GlobalKey();
  final intakeSummaryExpandController = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToSection(widget.scrollSection));
  }

  @override
  void didUpdateWidget(covariant DiaryView oldWidget) {
    if (widget.scrollSection != DiaryViewScrollSectionModel.none) {
      scrollToSection(widget.scrollSection);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    scrollController.dispose();
    voidingSummaryExpandController.dispose();
    intakeSummaryExpandController.dispose();
    super.dispose();
  }

  void scrollToSection(DiaryViewScrollSectionModel scrollSection) {
    final key = switch (scrollSection) {
      DiaryViewScrollSectionModel.voiding => voidingSummaryKey,
      DiaryViewScrollSectionModel.intake => intakeSummaryKey,
      _ => null,
    };

    final notifier = switch (scrollSection) {
      DiaryViewScrollSectionModel.voiding => voidingSummaryExpandController,
      DiaryViewScrollSectionModel.intake => intakeSummaryExpandController,
      _ => null,
    };

    if (key?.currentContext case final BuildContext context) {
      notifier?.value = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) Scrollable.ensureVisible(context).then((_) => widget.onApplyScrollSection());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: DiaryCalendarWidget(onChanged: context.read<DiaryCubit>().subscribe),
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
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
