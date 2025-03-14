// Flutter imports:
// Project imports:
import 'package:bladderly/core/di/di.dart';
import 'package:bladderly/domain/usecase/export_histories_usecase.dart';
import 'package:bladderly/presentation/feature/export/term/bloc/export_bloc.dart';
import 'package:bladderly/presentation/feature/export/term/export_report_term_view.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportReportTermBuilder extends StatelessWidget {
  const ExportReportTermBuilder({
    super.key,
    required this.onExportSuccess,
    required this.selectedDates,
  });

  final VoidCallback onExportSuccess;
  final List<DateTime> selectedDates;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExportBloc>(
      create: (_) => ExportBloc(exportHistoriesUsecase: getIt<ExportHistoriesUsecase>()),
      child: ExportReportTermView(onExportSuccess: onExportSuccess, selectedDates: selectedDates),
    );
  }
}
