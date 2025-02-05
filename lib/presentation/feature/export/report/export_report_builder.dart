import 'package:bradderly/core/di/di.dart';
import 'package:bradderly/domain/usecase/send_histories_export_reason_usecase.dart';
import 'package:bradderly/presentation/feature/export/report/bloc/export_report_bloc.dart';
import 'package:bradderly/presentation/feature/export/report/export_report_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportReportBuilder extends StatelessWidget {
  const ExportReportBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExportReportBloc>(
      create: (_) => ExportReportBloc(sendHistoriesExportReasonUsecase: getIt<SendHistoriesExportReasonUsecase>()),
      child: const ExportReportView(),
    );
  }
}
