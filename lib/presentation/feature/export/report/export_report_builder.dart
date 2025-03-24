// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/feature/export/report/export_report_view.dart';
import 'package:flutter/material.dart';
// Package imports:

class ExportReportBuilder extends StatelessWidget {
  const ExportReportBuilder({
    super.key,
    required this.selectedDates,
  });

  final List<DateTime> selectedDates;

  @override
  Widget build(BuildContext context) {
    return ExportReportView(selectedDates: selectedDates);
  }
}
