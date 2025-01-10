import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/datetime_extension.dart';
import 'package:bradderly/presentation/feature/diary/diary/widget/diary_calendar_widget.dart';
import 'package:bradderly/presentation/feature/diary/diary/widget/diary_today_summary_widget.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> with AutomaticKeepAliveClientMixin {
  late final _pageController = PageController(
    viewportFraction: 50 / MediaQuery.sizeOf(context).width,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: ListView(
              children: const [
                Gap(58),
                Gap(16),
                DiaryTodaySummaryWidget(),
                DiaryTodaySummaryWidget(),
                DiaryTodaySummaryWidget(),
                DiaryTodaySummaryWidget(),
                DiaryTodaySummaryWidget(),
              ],
            ),
          ),
          Positioned.fill(
            bottom: null,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 34 + MediaQuery.paddingOf(context).top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Assets.icon.icDialryCalendar.svg(),
                      const Gap(8),
                      Text(
                        DateTime.now().calendarHeader,
                        style: context.textStyleTheme.b20Bold.copyWith(
                          color: context.colorTheme.neutral.shade10,
                        ),
                      ),
                      const Spacer(),
                      Assets.icon.icDiaryExport.svg(),
                    ],
                  ),
                  SizedBox(
                    height: 112,
                    child: ListView.builder(
                      controller: _pageController,
                      physics: const CustomPageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 50,
                          child: Text(
                            '${index ~/ 31}',
                            style: context.textStyleTheme.b18Bold.copyWith(
                              color: context.colorTheme.neutral.shade10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
