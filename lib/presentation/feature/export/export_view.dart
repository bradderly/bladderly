import 'package:bladderly/presentation/feature/export/calendar/export_calendar_builder.dart';
import 'package:bladderly/presentation/feature/export/report/export_report_builder.dart';
import 'package:bladderly/presentation/feature/export/term/export_term_view.dart';
import 'package:flutter/material.dart';

class ExportView extends StatefulWidget {
  const ExportView({
    super.key,
    required this.historyDates,
  });

  final List<DateTime> historyDates;

  @override
  State<ExportView> createState() => _ExportViewState();
}

class _ExportViewState extends State<ExportView> {
  final pageContorller = PageController();

  List<DateTime> selectedDates = <DateTime>[];

  @override
  void dispose() {
    pageContorller.dispose();
    super.dispose();
  }

  void animateToPage(int page) {
    pageContorller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageContorller,
        children: [
          ExportCalendarBuilder(
            onTapNext: (dates) {
              setState(() => selectedDates = dates);
              animateToPage(1);
            },
            historyDates: widget.historyDates,
          ),
          ExportTermView(
            onExport: () => animateToPage(2),
            dates: selectedDates,
            email: 'ydu3328@naver.com',
          ),
          const ExportReportBuilder(),
        ],
      ),
    );
  }
}
