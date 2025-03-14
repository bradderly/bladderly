// Flutter imports:
import 'package:bladderly/presentation/feature/export/report/widget/export_report_app_bar.dart';
import 'package:bladderly/presentation/feature/export/survey/export_survey_builder.dart';
import 'package:bladderly/presentation/feature/export/term/export_report_term_builder.dart';
import 'package:flutter/material.dart';

class ExportReportView extends StatefulWidget {
  const ExportReportView({
    super.key,
    required this.selectedDates,
  });

  final List<DateTime> selectedDates;

  @override
  State<ExportReportView> createState() => _ExportReportViewState();
}

class _ExportReportViewState extends State<ExportReportView> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ExportReportAppBar(),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            ExportReportTermBuilder(
              onExportSuccess: () =>
                  pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
              selectedDates: widget.selectedDates,
            ),
            const ExportSurveyBuilder(),
          ],
        ),
      ),
    );
  }
}
