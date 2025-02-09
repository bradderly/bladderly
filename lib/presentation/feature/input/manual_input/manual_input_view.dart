import 'package:bradderly/domain/model/history.dart';
import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/feature/input/manual_input/leakage/manual_input_leakage_builder.dart';
import 'package:bradderly/presentation/feature/input/manual_input/voiding/manual_input_voiding_builder.dart';
import 'package:bradderly/presentation/feature/input/manual_input/widget/manual_input_tab_bar.dart';
import 'package:bradderly/presentation/feature/input/widget/input_record_time_widget.dart';
import 'package:bradderly/presentation/generated/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManualInputView extends StatefulWidget {
  const ManualInputView({
    super.key,
    this.history,
  });

  final History? history;

  @override
  State<ManualInputView> createState() => _ManualInputViewState();
}

class _ManualInputViewState extends State<ManualInputView> {
  late final pageController = PageController(
    initialPage: switch (widget.history) {
      final VoidingHistory _ => 0,
      final LeakageHistory _ => 1,
      _ => 0,
    },
  );

  late DateTime recordTime = widget.history?.recordTime ?? DateTime.now();

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
        toolbarHeight: 58,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 26, top: 18),
          child: InputRecordTimeWidget(
            onChanged: (dt) => setState(() => recordTime = dt),
            dateTime: recordTime,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: Navigator.of(context).pop,
            child: Assets.icon.icExportClose.svg(
              colorFilter: ColorFilter.mode(
                context.colorTheme.neutral.shade8,
                BlendMode.srcIn,
              ),
            ),
          ),
          const Gap(16),
        ],
        bottom: ManualInputTabBar(pageController: pageController),
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            ManualInputVoidingBuilder(recordTime: recordTime, history: widget.history),
            ManualInputLeakageBuilder(recordTime: recordTime, history: widget.history),
          ],
        ),
      ),
    );
  }
}
