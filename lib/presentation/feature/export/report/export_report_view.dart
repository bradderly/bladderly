// Flutter imports:
import 'package:bladderly/presentation/feature/export/report/widget/export_report_app_bar.dart';
import 'package:bladderly/presentation/feature/export/term/export_report_term_builder.dart';
import 'package:bladderly/presentation/router/route/export_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:flutter/material.dart';

class ExportReportView extends StatelessWidget {
  const ExportReportView({
    super.key,
    required this.selectedDates,
  });

  final List<DateTime> selectedDates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ExportReportAppBar(),
      body: SafeArea(
        child: ExportReportTermBuilder(
          onExportSuccess: () => const ExportSurveyRoute().go(context),
          selectedDates: selectedDates,
        ),
      ),
    );
  }
}
